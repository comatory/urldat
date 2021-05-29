String joinParts({
  required String base,
  required String path,
  required String query,
}) {
  final tail = [path, query].join();

  /* NOTE: In case path or template is empty string, tail becomes just
           query. Do not add slash but join parts together as they are
  */
  if (tail.startsWith('?')) {
    return [base, tail].join();
  }

  return [base, tail].join('/');
}

Map<String, String> stringifyValuesInMap(Map<String, dynamic> map) {
  final copy = Map<String, dynamic>.from(map);
  return copy
      .map((String key, dynamic value) => MapEntry(key, value.toString()));
}
