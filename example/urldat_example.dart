import 'package:urldat/urldat.dart';

/* NOTE: Run these examples with `--enable-asserts` flag */
void main() {
  /* Join two paths with slash */
  assert(
      urldat('https://dart.dev', '/get-dart') == 'https://dart.dev/get-dart');

  /* urldat helps you with leaving out double slashes */
  assert(
      urldat('https://dart.dev/', '/get-dart') == 'https://dart.dev/get-dart');

  /* Use templates to dynamically generate paths */
  assert(urldat('https://dart.dev/guides/', '/:section/:page', parameters: {
        'section': 'language',
        'page': 'language-tour',
      }) ==
      'https://dart.dev/guides/language/language-tour');

  /* Unused parameters are automatically converted to query parameters */
  assert(urldat('https://example.com', '/:section',
          parameters: {'section': 'search', 'q': 'hello', 'l': 'en US'}) ==
      'https://example.com/search?q=hello&l=en+US');

  /* Parameter values are always encoded, any value that implements
     `toString` method will first call that method
  */
  assert(urldat('https://example.com', '/:time', parameters: {
        'time': DateTime.utc(2020, 1, 1, 12, 0, 0),
        'id': 10,
      }) ==
      'https://example.com/2020-01-01%2012%3A00%3A00.000Z?id=10');

  /* Any extra slashes will be removed */
  assert(urldat('https://example.com/', '/hello//') ==
      'https://example.com/hello/');

  /* Any extra question marks will be removed */
  assert(urldat('https://example.com', '/path?', parameters: {'q': 'hello'}) ==
      'https://example.com/path?q=hello');

  /* Create a closure with preconfigured base path, perfect for re-use with
     similar API roots
  */
  final urldatConfig = urldatFactory('https://api.example.com/v1/users');
  assert(urldatConfig('/:id/posts/:postId',
          parameters: {'id': 10, 'postId': 200}) ==
      'https://api.example.com/v1/users/10/posts/200');

  /* If you want more convenience, pass `scheme` like http/https
     as an option.
  */
  assert(urldat('dart.dev', '/:section',
          parameters: {'section': 'search'}, scheme: 'https') ==
      'https://dart.dev/search');

  /* You can also specify port for base path */
  assert(urldat('dart.dev', '/:section',
          parameters: {'section': 'search'}, scheme: 'https', port: 3000) ==
      'https://dart.dev:3000/search');

  /* You can also specify fragment for path */
  assert(urldat('dart.dev', '/:section',
          parameters: {'section': 'search'},
          scheme: 'https',
          port: 3000,
          fragment: 'hello') ==
      'https://dart.dev:3000/search#hello');
}
