final templateRegex = RegExp(r'(:{1}[^:/]+)');
final fragmentRegex = RegExp(r'^.*\#\S*$');

bool isTemplate(String path) {
  return templateRegex.hasMatch(path);
}

bool hasScheme(Uri uri) {
  return uri.hasScheme;
}

bool hasFragment(String path) {
  return fragmentRegex.hasMatch(path);
}
