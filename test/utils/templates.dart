import 'package:test/test.dart';

import 'package:urlcat/src/utils/templates.dart';

void main() {
  group('getTemplateKeys', () {
    test('should extract template keys as set of strings', () {
      expect(getTemplateKeys('/:hello/:world'), equals({'hello', 'world'}));
    });

    test('should only extract template keys recognized by pattern', () {
      expect(getTemplateKeys('/base/:hello/a/:world:b'),
          equals({'hello', 'world'}));
    });
  });

  group('getQueryParameterKeys', () {
    test('should exclude template keys from query parameter keys', () {
      expect(getQueryParameterKeys({'a', 'b', 'c'}, {'a', 'c'}), equals({'b'}));
    });

    test(
        'should return all query parameter keys if no template keys are present',
        () {
      expect(getQueryParameterKeys({}, {'a', 'b'}), equals({'a', 'b'}));
    });

    test('should return empty set if no query parameter keys are present', () {
      expect(getQueryParameterKeys({'a', 'b'}, {}), equals({}));
    });
  });

  group('fillTemplateWithValues', () {
    test('should replace template keys with actual values', () {
      expect(
          fillTemplateWithValues(
              '/base/:a/b/:c', {'a', 'c'}, {'a': '1', 'b': '2'}),
          equals('/base/1/b/2'));
    });

    test(
        'should replace template keys and ignore any extra keys not present in template',
        () {
      expect(
          fillTemplateWithValues(
              '/base/:a/b/:c', {'a', 'c', 'd'}, {'a': '1', 'b': '2', 'd': '3'}),
          equals('/base/1/b/2'));
    });

    test('should encode replaced values in template', () {
      expect(
          fillTemplateWithValues(
            '/base/:a/:b',
            {'a', 'b'},
            {'a': 'A B', 'b': '+3'},
          ),
          equals('/base/A+B/%2B3'));
    });

    test('should stringify and encode complex values', () {
      expect(
          fillTemplateWithValues(
              '/base/:a/', {'a'}, {'a': DateTime.utc(2020, 1, 1, 12, 0, 0)}),
          equals('/base/2020-01-01%2012%3A00%3A00.000Z'));
    });
  });
}
