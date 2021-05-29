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
/// If [pathOrTemplate] is template (contains `:`) and no [parameters] are
/// provided, [UrldatError] exception will be thrown.
String urldat(
  String base,
  String pathOrTemplate, {
  Map<String, dynamic>? parameters,
}) {
  final sanitizedBase = removeTrailingSlash(base);
  final sanitizedPathWithoutSlash =
      removeLeadingAndTrailingSlash(pathOrTemplate);
  final sanitizedPath = removeTrailingQuestionMark(sanitizedPathWithoutSlash);

  if (isTemplate(sanitizedPath)) {
    if (parameters == null) {
      throw UrldatError(
          'When using path templates, you must pass parameters map.');
    }

    if (parameters.isEmpty) {
      throw UrldatError(
          'When using path templates, you must pass non-empty parameters map.');
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
    );
  }

  final queryParameters = createQueryParameters(parameters);

  return joinParts(
    base: sanitizedBase,
    path: sanitizedPath,
    query: queryParameters,
  );
}
