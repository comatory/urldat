import 'package:urlcat/urlcat.dart';
import 'package:test/test.dart';

void main() {
  group('urlcat', () {
    test('Concatenates the base URL and the path if no params are passed', () {
      expect(urlcat('http://example.com', 'path'),
          equals('http://example.com/path'));
    });

    test(
        'Uses exactly one slash for joining even if the base URL has a trailing slash',
        () {
      expect(urlcat('http://example.com/', 'path'),
          equals('http://example.com/path'));
    });

    test(
        'Uses exactly one slash for joining even if the path has a leading slash',
        () {
      expect(urlcat('http://example.com', '/path'),
          equals('http://example.com/path'));
    });

    test(
        'Uses exactly one slash for joining even if the base URL and the path both have a slash at the boundary',
        () {
      expect(urlcat('http://example.com/', '/path'),
          equals('http://example.com/path'));
    });

    test('Substitutes path parameters', () {
      expect(urlcat('http://example.com/', '/path/:p', parameters: {'p': 1}),
          'http://example.com/path/1');
    });

    test('Allows path parameters at the beginning of the path', () {
      expect(urlcat('http://example.com/', ':p', parameters: {'p': 1}),
          equals('http://example.com/1'));
    });

    test('Parameters that are missing from the path become query parameters',
        () {
      expect(
          urlcat('http://example.com/', '/path/:p',
              parameters: {'p': 1, 'q': 2}),
          equals('http://example.com/path/1?q=2'));
    });

    test(
        'Uses exactly one ? to join query parameters even if the path has a trailing question mark',
        () {
      expect(urlcat('http://example.com/', '/path?', parameters: {'q': 2}),
          equals('http://example.com/path?q=2'));
    });

    test(
        'Removes trailing question mark from the path if no params are specified',
        () {
      expect(urlcat('http://example.com/', '/path?', parameters: {}),
          equals('http://example.com/path'));
    });

    test('All parameters become query parameters if the path has no parameters',
        () {
      expect(
          urlcat('http://example.com/', '/path?', parameters: {'p': 1, 'q': 2}),
          equals('http://example.com/path?p=1&q=2'));
    });

    test('If a parameter appears twice in the path, it is substituted twice',
        () {
      expect(
          urlcat('http://example.com/', '/path/:p1/:p2/:p1/r',
              parameters: {'p1': 'a', 'p2': 'b'}),
          equals('http://example.com/path/a/b/a/r'));
    });

    test('Escapes both path and query parameters', () {
      expect(
          urlcat('http://example.com/', '/path/:p',
              parameters: {'p': 'a b', 'q': 'b c'}),
          equals('http://example.com/path/a%20b?q=b+c'));
    });

    test('Can handle complex URLs', () {
      expect(
          urlcat('http://example.com/', '/users/:userId/posts/:postId/comments',
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

    test('Provides an overload (baseUrl, pathTemplate) that works correctly',
        () {
      expect(urlcat('http://example.com/', '/path'),
          equals('http://example.com/path'));
    });

    /* NOTE: The original `urlcat` had to handle Javascript URL constructor
             but in Dart it's not needed:
             https://github.com/balazsbotond/urlcat/issues/7
    */
    test('Handles "//" path correctly', () {
      expect(
          urlcat('http://example.com/', '//'), equals('http://example.com/'));
    });

    test('Escape empty path params', () {
      expect(urlcat('http://example.com/path', '', parameters: {'p': 'a'}),
          equals('http://example.com/path?p=a'));
    });

    test('Renders boolean (true) path params', () {
      expect(urlcat('http://example.com', '/path/:p', parameters: {'p': true}),
          equals('http://example.com/path/true'));
    });

    test('Renders number path params', () {
      expect(urlcat('http://example.com/', 'path/:p', parameters: {'p': 456}),
          equals('http://example.com/path/456'));
    });

    test('Renders string path params', () {
      expect(
          urlcat('http://example.com', '/path/:p', parameters: {'p': 'test'}),
          equals('http://example.com/path/test'));
    });

    test('Ignores entirely numeric path params', () {
      expect(
          urlcat('http://localhost:3000', '/path/:p',
              parameters: {'p': 'test'}),
          equals('http://localhost:3000/path/test'));
    });
  });
}
