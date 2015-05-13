#!/bin/bash -e

dartanalyzer --fatal-warnings {bin,lib,example}/*.dart

pub run test
