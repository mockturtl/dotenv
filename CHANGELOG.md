changelog
=========

This project follows [pub-flavored semantic versioning][pub-semver].

Release notes are available on [github][notes].

[pub-semver]: https://www.dartlang.org/tools/pub/versioning.html#semantic-versions
[notes]: https://github.com/mockturtl/dotenv/releases

HEAD
----

- [deprecated] `Parser` methods will become private. [#3][]
    - `#unquote` `#strip`, `#swallow`, `#parseOne`, `#surroundingQuote`, `#interpolate`
- [deps] migrate to [test][]
- [deps] bump [logging][]

[test]: https://pub.dartlang.org/packages/test
[logging]: https://pub.dartlang.org/packages/logging

0.1.0
-----

Initial release.

[#3]: https://github.com/mockturtl/dotenv/issues/3
