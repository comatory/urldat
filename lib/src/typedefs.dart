typedef UrldatConfiguredFn = String Function(
  String pathOrTemplate, {
  Map<String, dynamic>? parameters,
  String? scheme,
  int? port,
});

typedef UrldatFn = String Function(
  String base,
  String pathOrTemplate, {
  Map<String, dynamic>? parameters,
  String? scheme,
  int? port,
});
