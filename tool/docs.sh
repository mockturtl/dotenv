#!/bin/sh
# Generate dartdoc documentation and preview in a browser.

docs="docs"

rm -r $docs && \
dartdoc && \
open $docs/index.html
