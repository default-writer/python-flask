#!/usr/bin/env bash
set -e

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

eval "$(source $HOME/.bashrc)"

exec bash -l

cd "${pwd}"