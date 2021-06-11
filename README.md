dotenv
======

Load environment variables at runtime from a `.env` file.

[![Pub Version][pub-badge]][pub]
[![Build Status][ci-badge]][ci]
[![Documentation][dartdocs-badge]][dartdocs]
[![style: tidy](https://img.shields.io/badge/style-tidy-43caf5.svg)][lint]


[ci-badge]: https://github.com/mockturtl/dotenv/workflows/dotenv/badge.svg
[ci]: https://github.com/mockturtl/dotenv/actions
[lint]: https://pub.dev/packages/tidy
[pub-badge]: https://img.shields.io/pub/v/dotenv.svg
[pub]: https://pub.dartlang.org/packages/dotenv
[dartdocs-badge]: https://img.shields.io/badge/dartdocs-reference-blue.svg
[dartdocs]: http://www.dartdocs.org/documentation/dotenv/latest

### about

Deploying applications should be simple.  This implies constraints:

> **The [twelve-factor app][12fa] stores [config][cfg] in _environment variables_**
> (often shortened to _env vars_ or _env_). Env vars are easy to change
> between deploys without changing any code... they are a language- and
> OS-agnostic standard.

[12fa]: http://www.12factor.net
[cfg]: http://12factor.net/config

An _environment_ is the set of variables known to a process (say, `PATH`, `PORT`, ...).
It is desirable to mimic the production environment during development (testing,
staging, ...) by reading these values from a file.

This library parses that file and optionally merges its values with the built-in
[`Platform.environment`][docs-io] map.

[docs-io]: https://api.dartlang.org/apidocs/channels/stable/dartdoc-viewer/dart:io.Platform#id_environment

### usage

See [documentation][usage] and [examples][].

[usage]: http://www.dartdocs.org/documentation/dotenv/latest/index.html#dotenv/dotenv
[examples]: https://github.com/mockturtl/dotenv/tree/master/example

### cli

Get the latest:

```sh
$ dart pub global activate dotenv
```

Run:

```sh
$ dart pub global run dotenv:new  # create a .env file and add it to .gitignore
$ dart pub global run dotenv      # load the file and print all the environment variables to stdout
$ dart pub global run dotenv -s     # load the file and print only the file environment variables to stdout
```

#### discussion

Use the [issue tracker][tracker] for bug reports and feature requests.

Pull requests gleefully considered.

[tracker]: https://github.com/mockturtl/dotenv/issues

###### prior art

- [bkeepers/dotenv][] (ruby)
- [motdotla/dotenv][] (node)
- [theskumar/python-dotenv][] (python)
- [joho/godotenv][] (go)
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

###### license: [MIT](LICENSE)
