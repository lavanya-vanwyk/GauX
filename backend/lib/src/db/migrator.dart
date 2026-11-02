import 'package:gaux_backend/src/db/migrations.dart';
import 'package:postgres/postgres.dart';

/// Applies pending [migrations] in order, each in its own transaction.
///
/// Holds a Postgres advisory lock while running, so several server
/// instances starting at once can't apply the same migration twice.
class Migrator {
  const Migrator(this._db);

  final Pool<void> _db;

  // Arbitrary, but fixed: identifies GauX's migration lock
  static const _lockId = 7426001;

  /// Returns the versions applied by this call.
  Future<List<int>> migrate() async {
    await _db.execute('''
      CREATE TABLE IF NOT EXISTS public.gaux_schema_migrations (
        version    integer PRIMARY KEY,
        name       text NOT NULL,
        applied_at timestamptz NOT NULL DEFAULT now()
      )''');

    final applied = <int>[];
    for (final (version, name, sql) in migrations) {
      final didApply = await _db.runTx((tx) async {
        await tx.execute('SELECT pg_advisory_xact_lock($_lockId)');
        final done = await tx.execute(
          Sql.named(
            'SELECT 1 FROM public.gaux_schema_migrations WHERE version = @v',
          ),
          parameters: {'v': version},
        );
        if (done.isNotEmpty) return false;
        await tx.execute(sql, queryMode: QueryMode.simple);
        await tx.execute(
          Sql.named(
            'INSERT INTO public.gaux_schema_migrations (version, name) '
            'VALUES (@v, @n)',
          ),
          parameters: {'v': version, 'n': name},
        );
        return true;
      });
      if (didApply) applied.add(version);
    }
    return applied;
  }
}
