/// Use this to detect when [urldat.urldat] throws due to invalid
/// combination of inputs.
/// If you want to detect types of error programatically, use [id] property
/// which will give you [UrldatErrorId] identifier.
class UrldatError implements Exception {
  UrldatError(String message, UrldatErrorId id) {
    _message = message;
    _id = id;
  }
  UrldatError.basePathSchemeError()
      : _message = 'Base path already contains a scheme. Remove scheme option.',
        _id = UrldatErrorId.basePathSchemeError;
  UrldatError.pathFragmentError()
      : _message =
            'Base path already contains a fragment. Remove fragment option.',
        _id = UrldatErrorId.pathFragmentError;
  UrldatError.missingParametersWithTemplateError()
      : _message = 'When using path templates, you must pass parameters map.',
        _id = UrldatErrorId.missingParametersWithTemplateError;
  UrldatError.emptyParametersWithTemplateError()
      : _message =
            'When using path templates, you must pass non-empty parameters map.',
        _id = UrldatErrorId.emptyParametersWithTemplateError;

  late String _message;
  late UrldatErrorId _id;

  UrldatErrorId get id => _id;

  @override
  String toString() {
    return [_id, _message].join('\n');
  }
}

/// ID for catching type of errors programatically
enum UrldatErrorId {
  basePathSchemeError,
  pathFragmentError,
  missingParametersWithTemplateError,
  emptyParametersWithTemplateError,
}
