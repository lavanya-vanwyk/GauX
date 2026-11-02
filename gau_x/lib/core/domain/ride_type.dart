import 'package:gaux_contracts/gaux_contracts.dart';

/// The ride products GauX offers. Shared by booking, trip tracking and the
/// wallet ledger.
enum RideType {
  private('GauX Private', RideKind.private),
  pool('GauX Pool', RideKind.pool);

  const RideType(this.displayName, this.kind);

  final String displayName;

  /// The same product as named in the API and the shared fare rules.
  final RideKind kind;
}
