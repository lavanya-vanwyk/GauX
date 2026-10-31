import '../../features/trip_tracking/domain/ports/trip_payment_port.dart';
import '../../features/wallet/domain/usecases/charge_wallet.dart';

/// Pays for trips from the GauX wallet. Lives in the app layer so neither
/// feature imports the other.
class WalletTripPaymentAdapter implements TripPaymentPort {
  const WalletTripPaymentAdapter(this._chargeWallet);

  final ChargeWallet _chargeWallet;

  @override
  Future<void> charge({
    required double amount,
    required String description,
  }) async {
    await _chargeWallet(amount: amount, description: description);
  }
}
