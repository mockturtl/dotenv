#!/bin/sh
j=$(nproc)

pub run test -j$j
