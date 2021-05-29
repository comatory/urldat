import 'package:test/test.dart';

import 'package:urldat/src/utils/queries.dart';

void main() {
  group('createQueryParameters', () {
    test('should return empty string if no parameters are present', () {
      expect(createQueryParameters(null), equals(''));
    });

    test('should return empty string if parameters are empty', () {
      expect(createQueryParameters({}), equals(''));
    });

    test('should create string from parameters map', () {
      expect(createQueryParameters({'a': 1, 'b': 'B'}), equals('?a=b&b=B'));
    });

    test('should encode values', () {
      expect(createQueryParameters({'a': 'b c'}), equals('?a=b+c'));
    });
  });

  group('createQueryParametersWithKeys', () {
    test('should return empty string if parameters are empty', () {
      expect(
          createQueryParametersWithKeys(<String, dynamic>{}, <String>{'key'}),
          equals(''));
    });

    test('should return empty string if keys are empty', () {
      expect(
          createQueryParametersWithKeys(<String, dynamic>{'a': 1}, <String>{}),
          equals(''));
    });

    test('should create string with corresponding keys and values', () {
      expect(createQueryParametersWithKeys({'a': 1, 'b': 'X'}, {'a', 'b'}),
          equals('?a=1&b=X'));
    });

    test('should ignore parameters not defined in keys', () {
      expect(createQueryParametersWithKeys({'a': 1, 'b': 'X'}, {'b'}),
          equals('?b=X'));
    });
  });
}
