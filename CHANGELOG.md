changelog
=========

This project follows [pub-flavored semantic versioning][pub-semver]. ([more][pub-semver-readme])

Release notes are available on [github][notes].

[pub-semver]: https://www.dartlang.org/tools/pub/versioning.html#semantic-versions
[pub-semver-readme]: https://pub.dartlang.org/packages/pub_semver
[notes]: https://github.com/mockturtl/dotenv/releases

HEAD
----

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
