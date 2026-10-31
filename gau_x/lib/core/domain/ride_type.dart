/// The ride products GauX offers. Shared by booking, trip tracking and the
/// wallet ledger.
enum RideType {
  private('GauX Private'),
  pool('GauX Pool');

  const RideType(this.displayName);

  final String displayName;
}
