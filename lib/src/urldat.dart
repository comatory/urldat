import './utils/utils.dart';
import './errors/errors.dart';

typedef Urldat = String Function(
  String base,
  String pathOrTemplate, {
  Map<String, dynamic>? parameters,
});

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
