import 'package:test/test.dart';

import 'package:urlcat/src/utils/sanitizers.dart';

void main() {
  group('removeTrailingSlash', () {
    test('should remove trailing slash from string', () {
      expect(removeTrailingSlash('/hello/'), equals('/hello'));
    });

    test('should return same string if trailing slash is not present', () {
      expect(removeTrailingSlash('/hello'), equals('/hello'));
    });

    test('should remove only trailing slash', () {
      expect(removeTrailingSlash('/hello/world/'), equals('/hello/world'));
    });
  });

  group('removeLeadingSlash', () {
    test('should remove leading slash from string', () {
      expect(removeLeadingSlash('/hello/'), equals('hello/'));
    });

    test('should return same string if leading slash is not present', () {
      expect(removeLeadingSlash('hello/'), equals('hello/'));
    });

    test('should remove only leading slash', () {
      expect(removeLeadingSlash('/hello/world/'), equals('hello/world/'));
    });
  });

  group('removeLeadingAndTrailingSlash', () {
    test('should remove both leading and trailing slash', () {
      expect(removeLeadingAndTrailingSlash('/hello/'), equals('hello'));
    });

    test(
        'should return same string if leading nor trailing slashes are present',
        () {
      expect(removeLeadingAndTrailingSlash('hello'), equals('hello'));
    });

    test('remove only leading and trailing slashes', () {
      expect(removeLeadingAndTrailingSlash('/hello/world/'),
          equals('hello/world'));
    });
  });

  group('removeTrailingQuestionMark', () {
    test('should remove trailing question mark from string', () {
      expect(removeTrailingQuestionMark('/hello?'), equals('/hello'));
    });

    test('should return same string if trailing question mark is not present',
        () {
      expect(removeTrailingQuestionMark('/hello'), equals('/hello'));
    });

    test('should return only traling question mark', () {
      expect(removeTrailingQuestionMark('/hello??'), equals('/hello?'));
    });
  });
}
