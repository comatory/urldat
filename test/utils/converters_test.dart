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

    test('should create base with passed in scheme', () {
      expect(
          joinParts(
            scheme: Uri(scheme: 'ftp').scheme,
            base: 'example.com',
            path: 'path',
            query: '',
          ),
          equals('ftp://example.com/path'));
    });

    test('should create base with port', () {
      expect(
          joinParts(
            port: 4004,
            base: 'example.com',
            path: 'path',
            query: '',
          ),
          equals('example.com:4004/path'));
    });

    test('should ignore port 80', () {
      expect(
          joinParts(
            port: 80,
            base: 'example.com',
            path: 'path',
            query: '',
          ),
          equals('example.com/path'));
    });

    test('should ignore port 0', () {
      expect(
          joinParts(
            port: 0,
            base: 'example.com',
            path: 'path',
            query: '',
          ),
          equals('example.com/path'));
    });

    test('should create base with port and scheme and query', () {
      expect(
          joinParts(
            port: 9911,
            scheme: 'ftp',
            base: 'example.com',
            path: 'path',
            query: '?search=what&category=1',
          ),
          equals('ftp://example.com:9911/path?search=what&category=1'));
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
