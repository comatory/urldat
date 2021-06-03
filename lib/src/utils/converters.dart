String joinParts({
  String? scheme,
  required String base,
  required String path,
  required String query,
}) {
  final baseWithScheme = scheme != null
    ? '$scheme://$base'
    : base;

  final tail = [path, query].join();

  /* NOTE: In case path or template is empty string, tail becomes just
           query. Do not add slash but join parts together as they are
  */
  if (tail.startsWith('?')) {
    return [baseWithScheme, tail].join();
  }

  return [baseWithScheme, tail].join('/');
}

Map<String, String> stringifyValuesInMap(Map<String, dynamic> map) {
  final copy = Map<String, dynamic>.from(map);
  return copy
      .map((String key, dynamic value) => MapEntry(key, value.toString()));
}
