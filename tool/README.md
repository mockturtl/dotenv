tool
====

Consider calling these in a git pre-commit hook.

### [fmt.sh][]

Runs the official [code formatter][].

[code formatter]: https://github.com/dart-lang/dart_style
[fmt.sh]: fmt.sh

###### setup

Ensure `~/.pub_cache/bin` is in your `$PATH`, and `dartfmt` is up to date:

```sh
$ pub global activate dart_style
```

### [test.sh][]

Runs the unit test suite.

[test.sh]: test.sh
