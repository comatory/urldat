typedef UrldatConfiguredFn = String Function(
  String pathOrTemplate, {
  Map<String, dynamic>? parameters,
});

typedef UrldatFn = String Function(
  String base,
  String pathOrTemplate, {
  Map<String, dynamic>? parameters,
});
