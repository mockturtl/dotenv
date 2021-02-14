#!/bin/sh -e

dart test --test-randomize-ordering-seed random "$@"
