String joinParts({
  required String base,
  required String path,
  required String query,
  String? scheme,
  int? port,
  String? fragment,
}) {
  final schemePart = scheme != null ? '$scheme://' : '';
  final portPart = (port != null && port != 0 && port != 80) ? ':$port' : '';
  final fragmentPart = fragment != null ? '#$fragment' : '';
  final baseWithSchemeAndPort = '$schemePart$base$portPart';

  final tail = [path, query].join();
  final tailWithFragment = '$tail$fragmentPart';

  /* NOTE: In case path or template is empty string, tail becomes just
           query. Do not add slash but join parts together as they are
  */
  if (tail.startsWith('?')) {
    return [baseWithSchemeAndPort, tailWithFragment].join();
  }

  return [baseWithSchemeAndPort, tailWithFragment].join('/');
}

Map<String, String> stringifyValuesInMap(Map<String, dynamic> map) {
  final copy = Map<String, dynamic>.from(map);
  return copy
      .map((String key, dynamic value) => MapEntry(key, value.toString()));
}
