import './urldat.dart';

typedef UrldatConfigured = String Function(
    String pathOrTemplate, Map<String, dynamic>? parameters);

UrldatConfigured urldatFactory(String base) {
  return (
    String pathOrTemplate,
    Map<String, dynamic>? parameters,
  ) =>
      urldat(base, pathOrTemplate, parameters: parameters);
}
