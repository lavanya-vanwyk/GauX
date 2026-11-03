/// Formats integer cents as rand: `4000` → "R 40.00", `-1250` → "-R 12.50".
///
/// All money in the app is integer cents; this is the only place it becomes
/// text. English formatting only until localisation moves this to `intl`.
String formatRand(int cents, {bool showPlus = false}) {
  final sign = cents < 0 ? '-' : (showPlus && cents > 0 ? '+' : '');
  final abs = cents.abs();
  final rand = abs ~/ 100;
  final remainder = (abs % 100).toString().padLeft(2, '0');
  return '${sign}R $rand.$remainder';
}
