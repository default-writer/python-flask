#!/usr/bin/env bash
set -e

pwd=$(pwd)

python3 -m pip install -r dev_requirements.txt

cd "${pwd}"
