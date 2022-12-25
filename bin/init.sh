#!/usr/bin/env bash
set -e

uid=$(id -u)

if [ "${uid}" -eq 0 ]; then
	echo "Please run as user"
	exit
fi

pwd=$(pwd)

"${pwd}/bin/env.sh" --nvm
"${pwd}/bin/env.sh" --pyenv

"${pwd}/bin/git.sh" --git
"${pwd}/bin/git.sh" --hooks

"${pwd}/bin/install.sh" --nvm
"${pwd}/bin/install.sh" --pyenv

nvm --version
nvm install 19.3.0
nvm use 19.3.0
npm install -g npm@9.2.0
echo "Node version $(node --version)"
echo "NPM version $(npm --version)"

"${pwd}/bin/runme.sh"

cd "${pwd}"