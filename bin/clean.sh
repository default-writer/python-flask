#!/usr/bin/env bash
set -e

pwd=$(pwd)

echo Cleans up uncommited changes and non-gited files and folders
git clean -f -q -d -x

cd "${pwd}"