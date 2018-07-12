#!/bin/sh
# Generate dartdoc documentation and preview in a browser.

doc="doc"

dartdoc && \
open "$doc"/api/index.html
