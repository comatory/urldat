import './detectors.dart';
import './sanitizers.dart';

Set<String> getTemplateKeys(String path) {
  return templateRegex.allMatches(path).map((match) {
    return removeLeadingAndTrailingSlash(
        path.substring(match.start + 1, match.end));
  }).toSet();
}

Set<String> getQueryParameterKeys(
    Set<String> templateKeys, Set<String> queryParameterKeys) {
  return queryParameterKeys.difference(templateKeys);
}

String fillTemplateWithValues(String template, Set<String> templateKeys,
    Map<String, dynamic> parameters) {
  return template.splitMapJoin(templateRegex,
      onMatch: (match) {
        final key = template.substring(match.start + 1, match.end);
        final rawValue = parameters[key];

        final value = rawValue != null ? '${rawValue.toString()}' : '';

        return Uri.encodeComponent(value);
      },
      onNonMatch: (str) => str);
}
