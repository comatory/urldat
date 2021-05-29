import './converters.dart';

String createQueryParametersWithKeys(
    Map<String, dynamic> parameters, Set<String> keys) {
  if (parameters.isEmpty || keys.isEmpty) {
    return '';
  }

  final copy = Map<String, dynamic>.from(parameters);
  copy.removeWhere((dynamic key, dynamic value) {
    return !keys.contains(key);
  });
  final convertedParameters = stringifyValuesInMap(copy);

  return Uri(queryParameters: convertedParameters).toString();
}

String createQueryParameters(Map<String, dynamic>? parameters) {
  if (parameters == null || parameters.keys.isEmpty) {
    return '';
  }

  return Uri(queryParameters: stringifyValuesInMap(parameters)).toString();
}
