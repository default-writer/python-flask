#!/usr/bin/env bash
set -e

uid=$(id -u)

if [ ! "${uid}" -eq 0 ]; then
    echo "Please run as root"
    exit
fi

pwd=$(pwd)

"${pwd}/bin/setup.sh" --llvm
"${pwd}/bin/setup.sh" --cmake
"${pwd}/bin/setup.sh" --pyenv

cd "${pwd}"