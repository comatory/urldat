import 'package:urlcat/urlcat.dart';

/* NOTE: Run these examples with `--enable-asserts` flag */
void main() {
  /* Join two paths with slash */
  assert(
      urlcat('https://dart.dev', '/get-dart') == 'https://dart.dev/get-dart');

  /* Urlcat helps you with leaving out double slashes */
  assert(
      urlcat('https://dart.dev/', '/get-dart') == 'https://dart.dev/get-dart');

  /* Use templates to dynamically generate paths */
  assert(urlcat('https://dart.dev/guides/', '/:section/:page', parameters: {
        'section': 'language',
        'page': 'language-tour',
      }) ==
      'https://dart.dev/guides/language/language-tour');

  /* Unused parameters are automatically converted to query parameters */
  assert(urlcat('https://example.com', '/:section',
          parameters: {'section': 'search', 'q': 'hello', 'l': 'en US'}) ==
      'https://example.com/search?q=hello&l=en+US');

  /* Parameter values are always encoded, any value that implements
     `toString` method will first call that method
  */
  assert(urlcat('https://example.com', '/:time', parameters: {
        'time': DateTime.utc(2020, 1, 1, 12, 0, 0),
        'id': 10,
      }) ==
      'https://example.com/2020-01-01%2012%3A00%3A00.000Z?id=10');

  /* Any extra slashes will be removed */
  assert(urlcat('https://example.com/', '/hello//') ==
      'https://example.com/hello/');

  /* Any extra question marks will be removed */
  assert(urlcat('https://example.com', '/path?', parameters: {'q': 'hello'}) ==
      'https://example.com/path?q=hello');
}
