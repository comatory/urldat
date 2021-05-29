/// urldat is a micro library that exposes [urldat] and
/// [urldatFactory] functions.
/// It is a simple utility that helps you with building URLs
/// in intuitive way while also making sure URLs have
/// correct format.
///
/// Example:
/// ```
/// urldat('https://example.com/', '/:section/item', parameters: {
///   'section': 'users',
///   's': 'hello'
///   'id': 1,
/// });
/// ```
/// This gives you `https://example.com/users/item?s=hello&id=1`.
library urldat;

export 'src/urldat.dart';
export 'src/urldat_factory.dart';
export 'src/errors/errors.dart';
export 'src/typedefs.dart';
