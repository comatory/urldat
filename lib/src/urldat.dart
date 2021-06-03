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
String urldat(
  String base,
  String pathOrTemplate, {
  Map<String, dynamic>? parameters,
  String? scheme
}) {
  final uri = Uri.parse(base);

  if (hasScheme(uri) && scheme != null) {
    throw UrldatError.basePathSchemeError();
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
      scheme: parsedScheme,
      base: sanitizedBase,
      path: filledTemplate,
      query: queryParameters,
    );
  }

  final queryParameters = createQueryParameters(parameters);

  return joinParts(
    scheme: parsedScheme,
    base: sanitizedBase,
    path: sanitizedPath,
    query: queryParameters,
  );
}
