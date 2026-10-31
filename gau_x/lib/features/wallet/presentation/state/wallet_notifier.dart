import 'dart:async';

import 'package:flutter/material.dart';

import '../../domain/entities/gold_card.dart';
import '../../domain/entities/ledger_entry.dart';
import '../../domain/repositories/gold_card_repository.dart';
import '../../domain/usecases/top_up_wallet.dart';

/// Wallet state for the UI. Follows the repository, so charges made
/// elsewhere (e.g. when a trip completes) show up here automatically.
class WalletNotifier extends ChangeNotifier {
  WalletNotifier({
    required GoldCardRepository repository,
    required TopUpWallet topUpWallet,
  }) : _topUpWallet = topUpWallet {
    _subscription = repository.watch().listen((card) {
      _card = card;
      notifyListeners();
    });
    unawaited(repository.load());
  }

  final TopUpWallet _topUpWallet;
  late final StreamSubscription<GoldCard> _subscription;

  GoldCard? _card;

  bool get isLoading => _card == null;
  double get balance => _card?.balance ?? 0;
  List<LedgerEntry> get ledger => _card?.ledger ?? const [];

  bool canAffordRide(double fareAmount) =>
      _card?.canAfford(fareAmount) ?? false;

  Future<void> topUpWallet(double amount, String paymentMethod) =>
      _topUpWallet(amount: amount, paymentMethod: paymentMethod);

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}
