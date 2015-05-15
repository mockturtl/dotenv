#!/bin/sh
# Generate dartdoc documentation and preview in a browser.

docs="docs"

rm -rf "$docs" && \
dartdoc && \
open $docs/index.html
