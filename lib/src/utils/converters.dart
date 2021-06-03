String joinParts({
  String? scheme,
  int? port,
  required String base,
  required String path,
  required String query,
}) {
  final schemePart = scheme != null ? '$scheme://' : '';
  final portPart = (port != null && port != 0 && port != 80) ? ':$port' : '';
  final baseWithSchemeAndPort = '$schemePart$base$portPart';

  final tail = [path, query].join();

  /* NOTE: In case path or template is empty string, tail becomes just
           query. Do not add slash but join parts together as they are
  */
  if (tail.startsWith('?')) {
    return [baseWithSchemeAndPort, tail].join();
  }

  return [baseWithSchemeAndPort, tail].join('/');
}

Map<String, String> stringifyValuesInMap(Map<String, dynamic> map) {
  final copy = Map<String, dynamic>.from(map);
  return copy
      .map((String key, dynamic value) => MapEntry(key, value.toString()));
}
