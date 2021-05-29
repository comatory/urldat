class UrldatError implements Exception {
  UrldatError(String message) {
    _message = message;
  }

  String _message = '';

  @override
  String toString() {
    return _message;
  }
}
