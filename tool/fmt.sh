#!/bin/sh

# Add to `.git/hooks/pre-commit`:
#   exec ./tool/fmt.sh

dartformat -w bin lib test example
