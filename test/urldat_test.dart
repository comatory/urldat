import 'package:test/test.dart';

import 'package:urldat/urldat.dart';

void main() {
  group('urldat', () {
    test('should concatenate the base URL and the path if no params are passed',
        () {
      expect(urldat('http://example.com', 'path'),
          equals('http://example.com/path'));
    });

    test(
        'should add exactly one slash for joining even if the base URL has a trailing slash',
        () {
      expect(urldat('http://example.com/', 'path'),
          equals('http://example.com/path'));
    });

    test(
        'should add exactly one slash for joining even if the path has a leading slash',
        () {
      expect(urldat('http://example.com', '/path'),
          equals('http://example.com/path'));
    });

    test(
        'should add exactly one slash for joining even if the base URL and the path both have a slash at the boundary',
        () {
      expect(urldat('http://example.com/', '/path'),
          equals('http://example.com/path'));
    });

    test('should substitute path parameters', () {
      expect(urldat('http://example.com/', '/path/:p', parameters: {'p': 1}),
          'http://example.com/path/1');
    });

    test('should allow path parameters at the beginning of the path', () {
      expect(urldat('http://example.com/', ':p', parameters: {'p': 1}),
          equals('http://example.com/1'));
    });

    test(
        'should convert parameters that are missing from the path to query parameters',
        () {
      expect(
          urldat('http://example.com/', '/path/:p',
              parameters: {'p': 1, 'q': 2}),
          equals('http://example.com/path/1?q=2'));
    });

    test(
        'should use exactly one ? to join query parameters even if the path has a trailing question mark',
        () {
      expect(urldat('http://example.com/', '/path?', parameters: {'q': 2}),
          equals('http://example.com/path?q=2'));
    });

    test(
        'should removes trailing question mark from the path if no params are specified',
        () {
      expect(urldat('http://example.com/', '/path?', parameters: {}),
          equals('http://example.com/path'));
    });

    test(
        'should convert all parameters to query parameters if the path has no parameters',
        () {
      expect(
          urldat('http://example.com/', '/path?', parameters: {'p': 1, 'q': 2}),
          equals('http://example.com/path?p=1&q=2'));
    });

    test(
        'should substitute parameter twice If a parameter appears twice in the path',
        () {
      expect(
          urldat('http://example.com/', '/path/:p1/:p2/:p1/r',
              parameters: {'p1': 'a', 'p2': 'b'}),
          equals('http://example.com/path/a/b/a/r'));
    });

    test('should escapes both path and query parameters', () {
      expect(
          urldat('http://example.com/', '/path/:p',
              parameters: {'p': 'a b', 'q': 'b c'}),
          equals('http://example.com/path/a%20b?q=b+c'));
    });

    test('should handle complex URLs', () {
      expect(
          urldat('http://example.com/', '/users/:userId/posts/:postId/comments',
              parameters: {
                'userId': 123,
                'postId': 987,
                'authorId': 456,
                'limit': 10,
                'offset': 120
              }),
          equals(
              'http://example.com/users/123/posts/987/comments?authorId=456&limit=10&offset=120'));
    });

    test(
        'should Provide an overload (baseUrl, pathTemplate) that works correctly',
        () {
      expect(urldat('http://example.com/', '/path'),
          equals('http://example.com/path'));
    });

    /* NOTE: The original `urlcat` had to handle Javascript URL constructor
             but in Dart it's not needed:
             https://github.com/balazsbotond/urlcat/issues/7
    */
    test('should handles "//" path correctly', () {
      expect(
          urldat('http://example.com/', '//'), equals('http://example.com/'));
    });

    test('should escape empty path params', () {
      expect(urldat('http://example.com/path', '', parameters: {'p': 'a'}),
          equals('http://example.com/path?p=a'));
    });

    test('should encode boolean (true) path params', () {
      expect(urldat('http://example.com', '/path/:p', parameters: {'p': true}),
          equals('http://example.com/path/true'));
    });

    test('should encode number path params', () {
      expect(urldat('http://example.com/', 'path/:p', parameters: {'p': 456}),
          equals('http://example.com/path/456'));
    });

    test('should encode string path params', () {
      expect(
          urldat('http://example.com', '/path/:p', parameters: {'p': 'test'}),
          equals('http://example.com/path/test'));
    });

    test('should ignores numeric path params entirely', () {
      expect(
          urldat('http://localhost:3000', '/path/:p',
              parameters: {'p': 'test'}),
          equals('http://localhost:3000/path/test'));
    });
  });

  group('additional options', () {
    test('should create URL with defined scheme', () {
      expect(
          urldat('dart.dev', '/path/:p',
              parameters: {'p': 'test'}, scheme: 'https'),
          equals('https://dart.dev/path/test'));
    });

    test(
        'should throw error when scheme option is defined and'
        'URL contains scheme as well', () {
      expect(
          () => urldat('https://dart.dev', '/path/:p',
              parameters: {'p': 'test'}, scheme: 'https'),
          throwsA(const TypeMatcher<UrldatError>()));
    });

    test('should create URL with defined port', () {
      expect(
          urldat('localhost', '/path/:p',
              parameters: {'p': 'test'}, port: 4000),
          equals('localhost:4000/path/test'));
    });

    test('should create URL with defined fragment', () {
      expect(
          urldat('https://dart.dev', '/path/:p',
              parameters: {'p': 'test'}, fragment: 'about'),
          equals('https://dart.dev/path/test#about'));
    });

    test(
        'should throw error when fragment option is defined and'
        'URL contains fragment as well', () {
      expect(
          () => urldat('https://dart.dev', '/path/:p#about',
              parameters: {'p': 'test'}, fragment: 'about'),
          throwsA(const TypeMatcher<UrldatError>()));
    });
  });
}
