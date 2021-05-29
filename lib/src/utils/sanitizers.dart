String removeTrailingSlash(String input) {
  if (input.endsWith('/')) {
    return input.substring(0, input.length - 1);
  }

  return input;
}

String removeLeadingSlash(String input) {
  if (input.startsWith('/')) {
    return input.substring(1, input.length);
  }

  return input;
}

String removeLeadingAndTrailingSlash(String input) {
  final sanitizedLeadingSlash = removeLeadingSlash(input);
  return removeTrailingSlash(sanitizedLeadingSlash);
}

String removeTrailingQuestionMark(String input) {
  if (input.endsWith('?')) {
    return input.substring(0, input.length - 1);
  }
  return input;
}
