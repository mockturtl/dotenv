#!/bin/sh
# Generate and serve documentation for this package.
#
# Dart renders HTML documentation from `/// special comments`.
# They can include include Markdown, code snippets, and template macros
# for eliminating redundant text blocks.

which dartdoc >/dev/null
ok=$?
if [ $ok -ne 0 ]; then
  cat <<EOF
  The Dart documentation generator is not installed.
  https://pub.dev/packages/dartdoc#generating-docs

  Run:
  dart pub global activate dartdoc
EOF
  exit 1
fi

which dhttpd >/dev/null
ok=$?
if [ $ok -ne 0 ]; then
  cat <<EOF
  The Dart HTTP server is not installed.
  https://pub.dev/packages/dartdoc#viewing-docs

  Run:
  dart pub global activate dhttpd
EOF
  exit 1
fi

dartdoc

dhttpd --path doc/api
