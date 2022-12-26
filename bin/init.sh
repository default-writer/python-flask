#!/usr/bin/env bash
set -e

pwd=$(pwd)

"${pwd}/bin/git.sh" --git
"${pwd}/bin/git.sh" --hooks

if [ "$(which nvm)" == "" ]; then
    "${pwd}/bin/install.sh" --nvm
    "${pwd}/bin/env.sh" --nvm
    eval "$(source $HOME/.bashrc)"
    "${pwd}/bin/venv.sh" --nvm
fi

if [ "$(which pyenv)" == "" ]; then
    "${pwd}/bin/install.sh" --pyenv
    "${pwd}/bin/env.sh" --pyenv
    eval "$(source $HOME/.bashrc)"
    "${pwd}/bin/venv.sh" --pyenv
fi

cd "${pwd}"