import 'package:test/test.dart';

import 'package:urldat/src/utils/detectors.dart';

void main() {
  group('isTemplate', () {
    test('should detect string is template by semicolon', () {
      expect(isTemplate(':template'), isTrue);
    });

    test('should not detect template when no semicolon is present', () {
      expect(isTemplate('/path'), isFalse);
    });
  });

  group('hasScheme', () {
    test('should detect that URI has scheme', () {
      expect(hasScheme(Uri.parse('https://dart.dev')), isTrue);
    });

    test('should NOT detect that URI has scheme', () {
      expect(hasScheme(Uri.parse('dart.dev')), isFalse);
    });
  });

  group('hasFragment', () {
    test('should detect that path has fragment', () {
      expect(hasFragment('/path/:section#fragment'), isTrue);
    });

    test('should NOT detect that path has fragment', () {
      expect(hasFragment('/path/:section'), isFalse);
    });
  });
}
