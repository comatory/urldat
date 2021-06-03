import './urldat.dart';
import './typedefs.dart';

/// This function creates a closure around base
/// [urldat.urldat] function. You pass [base] string URL
/// to this factory function and closure is returned
/// that allows you to call [urldat.urldat] without
/// explicitly passing [base] again. All other
/// arguments like `pathOrTemplate` and `parameters` apply.
/// This is simply convenience function to make use
/// of [urldat] more convenient.
UrldatConfiguredFn urldatFactory(String base) {
  return (
    String pathOrTemplate, {
    Map<String, dynamic>? parameters,
    String? scheme,
    int? port,
  }) =>
      urldat(base, pathOrTemplate, parameters: parameters);
}
