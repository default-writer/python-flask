#!/usr/bin/env bash
set -e

uid=$(id -u)

if [ "${uid}" -eq 0 ]; then
    echo "Please run as user"
    exit
fi

pwd=$(pwd)

"${pwd}/bin/git.sh" --git
"${pwd}/bin/git.sh" --hooks

if [ "$(which nvm)" == "" ]; then
    "${pwd}/bin/install.sh" --nvm
    "${pwd}/bin/env.sh" --nvm
fi

if [ "$(which pyenv)" == "" ]; then
    "${pwd}/bin/install.sh" --pyenv
    "${pwd}/bin/env.sh" --pyenv
fi

cd "${pwd}"