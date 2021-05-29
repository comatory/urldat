import 'package:test/test.dart';

import 'package:urlcat/src/utils/detectors.dart';

void main() {
  group('isTemplate', () {
    test('should detect string is template by semicolon', () {
      expect(isTemplate(':template'), isTrue);
    });

    test('should not detect template when no semicolon is present', () {
      expect(isTemplate('/path'), isFalse);
    });
  });
}
