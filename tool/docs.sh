#!/bin/sh
# Generate dartdoc documentation and preview in a browser.

outdir="doc/api"

rm -rf "$outdir" && \
dartdoc && \
open "$outdir"/index.html
