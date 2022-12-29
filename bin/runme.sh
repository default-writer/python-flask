#!/usr/bin/env bash
set -e

pwd=$(pwd)

"${pwd}/bin/venv.sh" --python
python3 -m pip install --upgrade pip
python3 -m pip install -r dev_requirements.txt

cd "${pwd}"
