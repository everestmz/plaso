#!/bin/bash
# Makes sure the environment is set up properly. For now, just checks if
# $PLASO_SRC is a real directory

set -e

# Check if $PLASO_SRC is set
if [ -z "$PLASO_SRC" ]; then
  echo "PLASO_SRC is not set - please set it and try again"
  exit 1
fi

# Check if $PLASO_SRC exists
if [ ! -d $PLASO_SRC ]; then
  echo "PLASO_SRC does not exist - please point to a valid directory"
  exit 1
fi
