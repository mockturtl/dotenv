tool
====

_Consider calling these in a git pre-commit hook._

Ensure `~/.pub_cache/bin` is in your `$PATH`.

### [fmt.sh][]

Runs the official [code formatter][].

[code formatter]: https://github.com/dart-lang/dart_style
[fmt.sh]: fmt.sh

###### setup

```sh
$ pub global activate dart_style
```

### [test.sh][]

Runs the unit test suite.

[test.sh]: test.sh

### [docs.sh][]

Preview [dartdoc][] documentation.

[docs.sh]: docs.sh
[dartdoc]: https://github.com/dart-lang/dartdoc

###### setup

```sh
$ pub global activate dartdoc
```
