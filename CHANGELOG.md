changelog
=========

This project follows [pub-flavored semantic versioning][pub-semver]. ([more][pub-semver-readme])

Release notes are available on [github][notes].

[pub-semver]: https://www.dartlang.org/tools/pub/versioning.html#semantic-versions
[pub-semver-readme]: https://pub.dartlang.org/packages/pub_semver
[notes]: https://github.com/mockturtl/dotenv/releases

3.1.0
-----

- DotEnv is now class based
- DotEnv does not load Platform.environment by default, use dotEnv instance for previous behavior. Existing methods `load` `clean` `isEveryDefined` and `env` work just like before. i.e no breaking change
- Variables from env can be accessed directly using array accessor, dotEnv['API_KEY'] works just like dotEnv.env['API_KEY']
- `dart pub global run dotenv -s` now allows skipping `Platform.environment` variables

3.0.0
-----

- BREAKING: bumps min Dart version to 2.12 for nullsafety [#27][]

2.0.0
-----

- BREAKING: change parser to handle `=` in values, e.g. base64 [#21][]

1.0.0
-----

- Dart 2 compatible. [#16][]

#### 0.1.3+3

- [docs] tweak README

#### 0.1.3+2

- [fix] don't throw if load fails [#11][]

#### 0.1.3+1

- [fix] allow braces with `${var}` substitution [#10][]

0.1.3
-----

- [new] add command-line interface [#7][], [#8][]
- [deps] add [args][]@v0.13

[args]: https://pub.dartlang.org/packages/args

0.1.2
-----

- [new] support variable substitution from `Platform.environment` [#6][]
- [deps] drop [logging][]

#### 0.1.1+2

- [fix] don't strip `#` inside quotes [#5][]

#### 0.1.1+1

- [fix] whitespace causes quotes not to be stripped

0.1.1
-----

- [deprecated] `Parser` internals will become private. [#3][]
    - `#unquote`, `#strip`, `#swallow`, `#parseOne`, `#surroundingQuote`, `#interpolate`
- [new] support variable substitution
- [deps] migrate to [test][]
- [deps] bump [logging][]

[test]: https://pub.dartlang.org/packages/test
[logging]: https://pub.dartlang.org/packages/logging

0.1.0
-----

Initial release.

[#3]: https://github.com/mockturtl/dotenv/issues/3
[#5]: https://github.com/mockturtl/dotenv/issues/5
[#6]: https://github.com/mockturtl/dotenv/issues/6
[#7]: https://github.com/mockturtl/dotenv/issues/7
[#8]: https://github.com/mockturtl/dotenv/issues/8
[#10]: https://github.com/mockturtl/dotenv/issues/10
[#11]: https://github.com/mockturtl/dotenv/issues/11
[#16]: https://github.com/mockturtl/dotenv/issues/16
[#21]: https://github.com/mockturtl/dotenv/pull/21
[#27]: https://github.com/mockturtl/dotenv/pull/27
