import 'package:test/test.dart';

import 'package:urldat/src/utils/converters.dart';

class TestClass {
  const TestClass({required this.value});

  final int value;

  @override
  String toString() {
    return 'test value $value';
  }
}

void main() {
  group('joinParts', () {
    test('concatenates base, path and query', () {
      expect(
          joinParts(
            base: 'http://example.com',
            path: 'path',
            query: '?hello',
          ),
          equals('http://example.com/path?hello'));
    });

    test('remove any extra question marks when query is empty', () {
      expect(
          joinParts(
            base: 'http://example.com',
            path: '?path',
            query: '',
          ),
          equals('http://example.com?path'));
    });

    test('concatenates with empty query', () {
      expect(
          joinParts(
            base: 'http://example.com',
            path: 'path',
            query: '',
          ),
          equals('http://example.com/path'));
    });
  });

  group('stringifyValuesInMap', () {
    test('should return same map when values are strings', () {
      expect(stringifyValuesInMap({'a': '1', 'b': '2'}),
          equals({'a': '1', 'b': '2'}));
    });

    test('should convert numeric values to string', () {
      expect(stringifyValuesInMap({'a': 1, 'b': 2.0}),
          equals({'a': '1', 'b': '2.0'}));
    });

    test('should stringify any objects', () {
      expect(
          stringifyValuesInMap(
              {'a': TestClass(value: 1), 'b': TestClass(value: 2)}),
          equals({'a': 'test value 1', 'b': 'test value 2'}));
    });
  });
}
