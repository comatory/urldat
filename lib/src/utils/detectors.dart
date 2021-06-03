final templateRegex = RegExp(r'(:{1}[^:/]+)');

bool isTemplate(String path) {
  return templateRegex.hasMatch(path);
}

bool hasScheme(Uri uri) {
  return uri.scheme.isNotEmpty;
}
