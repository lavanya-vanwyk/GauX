// Database migrations, applied in order by `Migrator`. Embedded in Dart so
// the compiled server carries them. Never edit a migration that has shipped;
// add a new one.

/// (version, name, sql)
const migrations = <(int, String, String)>[
  (1, 'ledger', _ledger),
  (2, 'api_role', _apiRole),
  (3, 'fare_holds', _fareHolds),
];

const _ledger = r'''
-- GauX wallet ledger: immutable double-entry bookkeeping.
--
-- Every movement of money is a journal entry with two or more postings whose
-- amounts sum to zero (e.g. rider wallet -2500, platform revenue +2500).
-- Entries and postings can never be updated or deleted; mistakes are fixed
-- with a reversing entry. Account balances are a cache of the postings,
-- maintained by trigger and checked by `account_reconciliation`.
--
-- All amounts are integer cents (ZAR).

CREATE SCHEMA IF NOT EXISTS gaux;
SET LOCAL search_path TO gaux;

CREATE TABLE accounts (
  id             uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  -- The rider (identity-provider subject) for wallets; NULL for system
  -- accounts
  owner_id       text,
  kind           text        NOT NULL CHECK (kind IN (
                   'rider_wallet',     -- what riders spend from
                   'platform_revenue', -- fares and fees GauX has earned
                   'topup_clearing',   -- money arriving from payment rails
                   'promotions'        -- free credit (e.g. opening balance)
                 )),
  currency       char(3)     NOT NULL DEFAULT 'ZAR',
  balance_cents  bigint      NOT NULL DEFAULT 0,
  -- Only system accounts that represent outside money may go negative
  allow_negative boolean     NOT NULL DEFAULT false,
  created_at     timestamptz NOT NULL DEFAULT now(),
  -- Postgres only lets a role lock rows (SELECT ... FOR UPDATE) if it may
  -- update some column. This is the only column the API role may update,
  -- so it can lock wallets without being able to change balances.
  lock_token     bigint      NOT NULL DEFAULT 0,
  CHECK (allow_negative OR balance_cents >= 0),
  CHECK ((kind = 'rider_wallet') = (owner_id IS NOT NULL))
);

CREATE UNIQUE INDEX accounts_one_wallet_per_rider
  ON accounts (owner_id, currency) WHERE kind = 'rider_wallet';
CREATE UNIQUE INDEX accounts_one_system_account_per_kind
  ON accounts (kind, currency) WHERE owner_id IS NULL;

INSERT INTO accounts (kind, allow_negative) VALUES
  ('platform_revenue', false),
  ('topup_clearing',   true),
  ('promotions',       true);

-- A price the server calculated for a ride. Charges refer to a quote, so
-- clients never choose the amount.
CREATE TABLE quotes (
  id              uuid             PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_id        text             NOT NULL,
  ride_type       text             NOT NULL CHECK (ride_type IN ('private', 'pool')),
  distance_meters double precision NOT NULL CHECK (distance_meters >= 0),
  fare_cents      bigint           NOT NULL CHECK (fare_cents >= 0),
  -- The pricing used, so partial fares are computed with the same rates
  pricing         jsonb            NOT NULL,
  created_at      timestamptz      NOT NULL DEFAULT now(),
  -- Rides must start before this; charging is allowed for a while after
  expires_at      timestamptz      NOT NULL
);

CREATE INDEX quotes_owner ON quotes (owner_id, created_at DESC);

CREATE TABLE journal_entries (
  id                uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  -- Who asked for this entry; with idempotency_key it makes retries safe
  owner_id          text        NOT NULL,
  idempotency_key   text        NOT NULL,
  kind              text        NOT NULL CHECK (kind IN (
                      'opening_balance', 'top_up', 'ride_charge',
                      'cancellation_fee', 'reversal'
                    )),
  description       text        NOT NULL,
  quote_id          uuid        REFERENCES quotes (id),
  reverses_entry_id uuid        REFERENCES journal_entries (id),
  created_at        timestamptz NOT NULL DEFAULT now(),
  UNIQUE (owner_id, idempotency_key),
  CHECK ((kind = 'reversal') = (reverses_entry_id IS NOT NULL))
);

-- A quote is paid at most once: either the full fare or a cancellation fee
CREATE UNIQUE INDEX journal_entries_one_charge_per_quote
  ON journal_entries (quote_id) WHERE quote_id IS NOT NULL;
-- An entry is reversed at most once
CREATE UNIQUE INDEX journal_entries_one_reversal_per_entry
  ON journal_entries (reverses_entry_id) WHERE reverses_entry_id IS NOT NULL;

CREATE TABLE postings (
  id           bigserial   PRIMARY KEY,
  entry_id     uuid        NOT NULL REFERENCES journal_entries (id),
  account_id   uuid        NOT NULL REFERENCES accounts (id),
  amount_cents bigint      NOT NULL CHECK (amount_cents <> 0),
  created_at   timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX postings_by_account ON postings (account_id, id DESC);
CREATE INDEX postings_by_entry ON postings (entry_id);

-- Immutability -------------------------------------------------------------

CREATE FUNCTION reject_change() RETURNS trigger
  LANGUAGE plpgsql SET search_path = gaux AS $$
BEGIN
  RAISE EXCEPTION '% is append-only: % is not allowed', TG_TABLE_NAME, TG_OP
    USING ERRCODE = 'integrity_constraint_violation';
END;
$$;

CREATE TRIGGER journal_entries_append_only
  BEFORE UPDATE OR DELETE ON journal_entries
  FOR EACH ROW EXECUTE FUNCTION reject_change();
CREATE TRIGGER journal_entries_no_truncate
  BEFORE TRUNCATE ON journal_entries
  FOR EACH STATEMENT EXECUTE FUNCTION reject_change();
CREATE TRIGGER postings_append_only
  BEFORE UPDATE OR DELETE ON postings
  FOR EACH ROW EXECUTE FUNCTION reject_change();
CREATE TRIGGER postings_no_truncate
  BEFORE TRUNCATE ON postings
  FOR EACH STATEMENT EXECUTE FUNCTION reject_change();

-- Balances -----------------------------------------------------------------

-- Keeps accounts.balance_cents equal to the sum of the account's postings.
-- The CHECK on accounts then rejects any posting that would overdraw a
-- wallet, even if application code forgot to check.
--
-- SECURITY DEFINER: runs with the schema owner's rights, so the API's
-- database role only needs SELECT/INSERT and can't edit balances directly.
CREATE FUNCTION apply_posting() RETURNS trigger
  LANGUAGE plpgsql SECURITY DEFINER SET search_path = gaux AS $$
BEGIN
  UPDATE accounts
     SET balance_cents = balance_cents + NEW.amount_cents
   WHERE id = NEW.account_id;
  RETURN NEW;
END;
$$;

CREATE TRIGGER postings_apply_to_balance
  AFTER INSERT ON postings
  FOR EACH ROW EXECUTE FUNCTION apply_posting();

-- Double entry: at commit, every entry's postings must sum to zero and there
-- must be at least two of them. Deferred so an entry's postings can be
-- inserted one at a time within the transaction.
CREATE FUNCTION check_entry_balanced() RETURNS trigger
  LANGUAGE plpgsql SET search_path = gaux AS $$
DECLARE
  total bigint;
  legs  integer;
BEGIN
  SELECT coalesce(sum(amount_cents), 0), count(*)
    INTO total, legs
    FROM postings
   WHERE entry_id = NEW.entry_id;
  IF total <> 0 OR legs < 2 THEN
    RAISE EXCEPTION 'journal entry % is unbalanced (sum %, % postings)',
      NEW.entry_id, total, legs
      USING ERRCODE = 'integrity_constraint_violation';
  END IF;
  RETURN NULL;
END;
$$;

CREATE CONSTRAINT TRIGGER postings_balanced
  AFTER INSERT ON postings
  DEFERRABLE INITIALLY DEFERRED
  FOR EACH ROW EXECUTE FUNCTION check_entry_balanced();

-- An entry with no postings at all would escape the check above
CREATE FUNCTION check_entry_has_postings() RETURNS trigger
  LANGUAGE plpgsql SET search_path = gaux AS $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM postings WHERE entry_id = NEW.id) THEN
    RAISE EXCEPTION 'journal entry % has no postings', NEW.id
      USING ERRCODE = 'integrity_constraint_violation';
  END IF;
  RETURN NULL;
END;
$$;

CREATE CONSTRAINT TRIGGER journal_entries_have_postings
  AFTER INSERT ON journal_entries
  DEFERRABLE INITIALLY DEFERRED
  FOR EACH ROW EXECUTE FUNCTION check_entry_has_postings();

-- Accounts whose cached balance disagrees with their postings. Should
-- always be empty; monitor it.
CREATE VIEW account_reconciliation AS
SELECT a.id, a.kind, a.owner_id, a.balance_cents,
       coalesce(sum(p.amount_cents), 0) AS postings_total
  FROM accounts a
  LEFT JOIN postings p ON p.account_id = a.id
 GROUP BY a.id
HAVING a.balance_cents <> coalesce(sum(p.amount_cents), 0);
''';

const _apiRole = r'''
-- Least-privilege role for the API process. The migration owner keeps DDL
-- rights; the API can read everything, append to the ledger, and create
-- quotes and wallets, but can't update or delete ledger rows (the triggers
-- would refuse anyway) or change balances directly.
--
-- Create the login user separately, with a real password, e.g.:
--   CREATE ROLE gaux_api_login LOGIN PASSWORD '...' IN ROLE gaux_api;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'gaux_api') THEN
    CREATE ROLE gaux_api NOLOGIN;
  END IF;
END;
$$;

GRANT USAGE ON SCHEMA gaux TO gaux_api;
GRANT SELECT ON ALL TABLES IN SCHEMA gaux TO gaux_api;
GRANT INSERT ON gaux.journal_entries, gaux.postings, gaux.quotes TO gaux_api;
GRANT INSERT (owner_id, kind, currency) ON gaux.accounts TO gaux_api;
-- Needed to lock wallet rows with SELECT ... FOR UPDATE (see lock_token)
GRANT UPDATE (lock_token) ON gaux.accounts TO gaux_api;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA gaux TO gaux_api;
''';

const _fareHolds = '''
-- Fare holds: when a ride is confirmed, its fare moves from the rider's
-- wallet into the rider_holds account, so it can't be spent elsewhere
-- mid-ride. On arrival or cancellation the hold is settled (fee to revenue,
-- any remainder back to the wallet); if the ride never happens it is
-- released. Every step is an ordinary balanced, append-only journal entry.

SET LOCAL search_path TO gaux;

ALTER TABLE accounts DROP CONSTRAINT accounts_kind_check;
ALTER TABLE accounts ADD CONSTRAINT accounts_kind_check CHECK (kind IN (
  'rider_wallet', 'platform_revenue', 'topup_clearing', 'promotions',
  'rider_holds' -- money reserved for rides in progress
));

INSERT INTO accounts (kind, allow_negative) VALUES ('rider_holds', false);

ALTER TABLE journal_entries DROP CONSTRAINT journal_entries_kind_check;
ALTER TABLE journal_entries ADD CONSTRAINT journal_entries_kind_check
  CHECK (kind IN (
    'opening_balance', 'top_up', 'ride_charge', 'cancellation_fee',
    'reversal', 'hold', 'hold_release'
  ));

-- A quote now has a hold entry and later a charge or release entry, so
-- "one entry per quote" becomes "one of each kind per quote"
DROP INDEX journal_entries_one_charge_per_quote;
CREATE UNIQUE INDEX journal_entries_one_charge_per_quote
  ON journal_entries (quote_id)
  WHERE quote_id IS NOT NULL AND kind IN ('ride_charge', 'cancellation_fee');
CREATE UNIQUE INDEX journal_entries_one_hold_per_quote
  ON journal_entries (quote_id) WHERE kind = 'hold';
CREATE UNIQUE INDEX journal_entries_one_release_per_quote
  ON journal_entries (quote_id) WHERE kind = 'hold_release';

-- Operational state of each hold. The money itself is in the ledger; this
-- tracks which holds are still open so they can be settled or released.
CREATE TABLE holds (
  id               uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_id         text        NOT NULL,
  quote_id         uuid        NOT NULL UNIQUE REFERENCES quotes (id),
  amount_cents     bigint      NOT NULL CHECK (amount_cents > 0),
  status           text        NOT NULL DEFAULT 'active'
                     CHECK (status IN ('active', 'settled', 'released')),
  hold_entry_id    uuid        NOT NULL REFERENCES journal_entries (id),
  closing_entry_id uuid        REFERENCES journal_entries (id),
  created_at       timestamptz NOT NULL DEFAULT now(),
  closed_at        timestamptz,
  CHECK ((status = 'active') = (closing_entry_id IS NULL))
);

CREATE INDEX holds_active_by_owner ON holds (owner_id) WHERE status = 'active';

GRANT SELECT, INSERT ON holds TO gaux_api;
GRANT UPDATE (status, closing_entry_id, closed_at) ON holds TO gaux_api;
''';
