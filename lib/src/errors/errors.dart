/// Use this to detect when [urldat.urldat] throws due to invalid
/// combination of inputs.
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
