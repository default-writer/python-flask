#!/usr/bin/env bash
set -e

pwd=$(pwd)

"${pwd}/bin/git.sh" --git
"${pwd}/bin/git.sh" --hooks

if [ "$(which nvm)" == "" ]; then
    eval "$(source ${pwd}/bin/nvm.sh)"
    "${pwd}/bin/install.sh" --nvm
    "${pwd}/bin/env.sh" --nvm
    "${pwd}/bin/venv.sh" --nvm
fi

if [ "$(which pyenv)" == "" ]; then
    eval "$(source ${pwd}/bin/pyenv.sh)"
    "${pwd}/bin/install.sh" --pyenv
    "${pwd}/bin/env.sh" --pyenv
    "${pwd}/bin/venv.sh" --pyenv
fi

cd "${pwd}"

