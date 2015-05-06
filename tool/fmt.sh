#!/bin/sh

# Add to `.git/hooks/pre-commit`:
#   exec ./tool/fmt.sh

dartfmt -w bin lib test example
