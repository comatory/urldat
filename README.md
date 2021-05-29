Convenient URL builder

## Description

This library is inspired by Javascript package [urlcat](https://www.npmjs.com/package/urlcat).
It's a loose port with slightly different API.

Library exposes simple `urldat` function that helps you build URLs effectively
while avoiding typical mis-steps, like double slashes or unencoded values.

## Features

* Friendly API
* No dependencies, uses core Dart library
* Simple source code, easy to fork

## Usage

A simple usage example:

```dart
import 'package:urldat/urldat.dart';

main() {
  final url = urldat(
    'https://example.com',
    '/path',
    parameters: { 'q': 'search', 't': DateTime.now() });

  http.get(url);
}
```

/* TODO */
## Feature requests and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
