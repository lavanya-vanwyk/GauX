/// How trip tracking charges the rider, without depending on the wallet
/// feature. The app layer connects this to the wallet.
abstract interface class TripPaymentPort {
  Future<void> charge({required double amount, required String description});
}
