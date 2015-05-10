dotenv
======

Load environment variables at runtime from a `.env` file.

[![Pub Version][pub-badge]][pub]
[![Build Status][ci-badge]][ci]

_NB: Travis uses [`test_runner`][], which has not yet moved off `unittest`._

[`test_runner`]: https://github.com/google/test_runner.dart/blob/master/pubspec.yaml

[ci-badge]: https://travis-ci.org/mockturtl/dotenv.svg?branch=master
[ci]: https://travis-ci.org/mockturtl/dotenv
[pub-badge]: https://img.shields.io/pub/v/dotenv.svg
[pub]: https://pub.dartlang.org/packages/dotenv

usage
-----

Prefix the library import and call `load()`, exposing the `env` map
with a top-level getter.

```dart
import 'package:dotenv/dotenv.dart' as dotenv;

Map<String, String> get _env => dotenv.env;

void main() {
  dotenv.load();
  var x = _env['foo'];
  // ...
}
```
Verify required variables are present:

```dart
const _requiredEnvVars = const ['host', 'port'];

bool get hasEnv => dotenv.isEveryDefined(_requiredEnvVars);
```

### limitations

Variable substitution and character escaping is a work in progress.  Some cases don't work yet.  Pull requests gleefully considered.

###### prior art

- [bkeepers/dotenv][] (ruby)
- [motdotla/dotenv][] (node)
- [theskumar/python-dotenv][] (python)
- [joho/godotenv][] (golang)
- [slapresta/rust-dotenv][] (rust)
- [chandu/dotenv][] (c#)
- [tpope/lein-dotenv][], [rentpath/clj-dotenv][] (clojure)
- [mefellows/sbt-dotenv][] (scala)
- [greenspun/dotenv][] (half of common lisp)

[bkeepers/dotenv]: https://github.com/bkeepers/dotenv
[motdotla/dotenv]: https://github.com/motdotla/dotenv
[theskumar/python-dotenv]: https://github.com/theskumar/python-dotenv
[joho/godotenv]: https://github.com/joho/godotenv
[slapresta/rust-dotenv]: https://github.com/slapresta/rust-dotenv
[chandu/dotenv]: https://github.com/Chandu/DotEnv
[tpope/lein-dotenv]: https://github.com/tpope/lein-dotenv
[rentpath/clj-dotenv]: https://github.com/rentpath/clj-dotenv
[mefellows/sbt-dotenv]: https://github.com/mefellows/sbt-dotenv
[greenspun/dotenv]: https://www.youtube.com/watch?v=pUjJU8Bbn3g
