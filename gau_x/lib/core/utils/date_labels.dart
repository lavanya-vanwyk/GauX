const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', //
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

/// A short, relative label for a past moment: "Just now", "Today, 08:15",
/// "Yesterday, 17:30" or "12 Oct, 09:05".
///
/// English only; moves to `intl` with localisation.
String relativeDateLabel(DateTime moment, {required DateTime now}) {
  if (now.difference(moment).inMinutes.abs() < 1) return 'Just now';

  final time =
      '${moment.hour.toString().padLeft(2, '0')}:'
      '${moment.minute.toString().padLeft(2, '0')}';
  final today = DateTime(now.year, now.month, now.day);
  final day = DateTime(moment.year, moment.month, moment.day);
  final daysAgo = today.difference(day).inDays;

  if (daysAgo == 0) return 'Today, $time';
  if (daysAgo == 1) return 'Yesterday, $time';
  return '${moment.day} ${_months[moment.month - 1]}, $time';
}
