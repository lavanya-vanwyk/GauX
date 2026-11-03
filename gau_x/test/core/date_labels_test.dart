import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/core/utils/date_labels.dart';

void main() {
  final now = DateTime(2026, 10, 31, 12, 0);

  test('labels moments under a minute old as just now', () {
    expect(
      relativeDateLabel(now.subtract(const Duration(seconds: 30)), now: now),
      'Just now',
    );
  });

  test('labels today and yesterday with the time', () {
    expect(
      relativeDateLabel(DateTime(2026, 10, 31, 8, 15), now: now),
      'Today, 08:15',
    );
    expect(
      relativeDateLabel(DateTime(2026, 10, 30, 17, 30), now: now),
      'Yesterday, 17:30',
    );
  });

  test('labels older moments with day and month', () {
    expect(
      relativeDateLabel(DateTime(2026, 10, 12, 9, 5), now: now),
      '12 Oct, 09:05',
    );
  });
}
