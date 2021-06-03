import './utils/utils.dart';
import './errors/errors.dart';

/// Function that takes [base] string URL and [pathOrTemplate] string URL.
/// [pathOrTemplate] can be either:
///
/// * path segment like `/path/to/something`
/// * or path segment template like `/users/:id/comments/`
///
/// If [parameters] map is provided, the template keys in [pathOrTemplate]
/// are substituted with the values from [parameters].
/// Extra keys in [parameters] that do not map to [pathOrTemplate] are
/// always used as query parameters.
///
/// If [pathOrTemplate] is template (contains `:colon`) and no [parameters] are
/// provided, [UrldatError] exception will be thrown.
///
/// [scheme] option is a valid URI scheme. It's intended to be used
/// with [base] URL when no scheme is present in it.
/// Warning: Function will throw [UrldatError] when [base] path contains
/// scheme already.
///
/// [port] option is a integer describing the port number, zero or 80 are
/// ignored in the final URL
///
/// [fragment] option will append fragment to URL. When URL already contains
/// fragment value, [UrldatError] will be thrown
String urldat(String base, String pathOrTemplate,
    {Map<String, dynamic>? parameters,
    String? scheme,
    int? port,
    String? fragment}) {
  final uri = Uri.parse(base);

  if (hasScheme(uri) && scheme != null) {
    throw UrldatError.basePathSchemeError();
  }

  if (hasFragment(pathOrTemplate) && fragment != null) {
    throw UrldatError.pathFragmentError();
  }

  final parsedScheme = scheme != null ? Uri(scheme: scheme).scheme : null;

  final sanitizedBase = removeTrailingSlash(base);
  final sanitizedPathWithoutSlash =
      removeLeadingAndTrailingSlash(pathOrTemplate);
  final sanitizedPath = removeTrailingQuestionMark(sanitizedPathWithoutSlash);

  if (isTemplate(sanitizedPath)) {
    if (parameters == null) {
      throw UrldatError.missingParametersWithTemplateError();
    }

    if (parameters.isEmpty) {
      throw UrldatError.emptyParametersWithTemplateError();
    }

    final templateKeys = getTemplateKeys(sanitizedPath);
    final queryParameterKeys =
        getQueryParameterKeys(templateKeys, parameters.keys.toSet());

    final filledTemplate =
        fillTemplateWithValues(sanitizedPath, templateKeys, parameters);
    final queryParameters =
        createQueryParametersWithKeys(parameters, queryParameterKeys);

    return joinParts(
      base: sanitizedBase,
      path: filledTemplate,
      query: queryParameters,
      scheme: parsedScheme,
      port: port,
      fragment: fragment,
    );
  }

  final queryParameters = createQueryParameters(parameters);

  return joinParts(
    base: sanitizedBase,
    path: sanitizedPath,
    query: queryParameters,
    scheme: parsedScheme,
    port: port,
    fragment: fragment,
  );
}
