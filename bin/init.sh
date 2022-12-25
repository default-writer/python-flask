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

[ ! $(which nvm) == "" ] && "${pwd}/bin/env.sh" --nvm && "${pwd}/bin/install.sh" --nvm
[ ! $(which pyenv) == "" ] && "${pwd}/bin/env.sh" --pyenv && "${pwd}/bin/install.sh" --pyenv
[ ! $(which nvm) == "" ] && nvm install 19.3.0 && nvm use 19.3.0 && npm install -g npm@9.2.0

echo "Node version $(node --version)"
echo "NPM version $(npm --version)"
echo "Pyenv version $(pyenv --version)"

sudo "${pwd}/bin/setup.sh" --llvm
sudo "${pwd}/bin/setup.sh" --cmake
sudo "${pwd}/bin/setup.sh" --pyenv
"${pwd}/bin/venv.sh" --pyenv
"${pwd}/bin/venv.sh" --venv

"${pwd}/bin/runme.sh"

cd "${pwd}"