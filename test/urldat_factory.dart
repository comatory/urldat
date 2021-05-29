import 'package:test/test.dart';

import 'package:urldat/urldat.dart';

void main() {
  group('urldatFactory', () {
    test('should produce a function', () {
      expect(urldatFactory('https://example.com'), matches(urldat));
    });

    test('should call produced function with provided base URL', () {
      final urldatConfig = urldatFactory('https://example.com');

      expect(
          urldatConfig('/path/:id', {
            'id': 11,
            's': 'helloworld',
          }),
          equals('https://example.com/path/11?s=helloworld'));
    });
  });
}
