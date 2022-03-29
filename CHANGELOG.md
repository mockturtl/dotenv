changelog
=========

This project follows [pub-flavored semantic versioning][pub-semver]. ([more][pub-semver-readme])

[pub-semver]: https://www.dartlang.org/tools/pub/versioning.html#semantic-versions
[pub-semver-readme]: https://pub.dartlang.org/packages/pub_semver

4.0.0
-----

- BREAKING: top-level functions have been removed.  Use a `DotEnv()` instance instead.
- BREAKING: the underlying `Map<String, String>` is no longer exposed.  Use the forwarding methods on `DotEnv` instead.
- BREAKING: by default, the underlying map does **not** include `Platform.environment`.
  - Libraries should use `DotEnv(includePlatformEnvironment: true)`.
  - The `dotenv` command should use the `--merge-platform-vars` flag.
- BREAKING: duplicate keys are now **overwritten**, instead of ignored.
- [feat] the `DotEnv.load()` method accepts multiple file paths.

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
