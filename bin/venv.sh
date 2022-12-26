#!/usr/bin/env bash
set -e

pwd=$(pwd)

install="$1"

case "${install}" in

    "--nvm") # installs nvm
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
        nvm install node
        nvm use node
        npm install -g npm@9.2.0
        ;;

    "--pyenv") # installs pyenv virtual environment for 3.11.1 into .venv folder
        export PYENV_VIRTUALENV_DISABLE_PROMPT=1
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
        pyenv install -f 3.11.1
        pyenv virtualenv -f 3.11.1 .venv
        pyenv activate .venv
        ;;

    "--python") # installs python3 venv virtual environment into .venv folder
        rm -rf .venv
        python3 -m venv .venv
        eval "$(source ${pwd}/.venv/bin/activate)"
        ;;

    *)
        commands=$(cat $0 | sed -e 's/^[ \t]*//;' | sed -e '/^[ \t]*$/d' | sed -n -e 's/^"\(.*\)".*#/    \1:/p' | sed -n -e 's/: /:\n        /p')
        script="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
        help=$(\
cat << EOF
Uninstalls optional dependencies
Usage: ${script} <option>
${commands}
EOF
)
        echo "${help}"
        exit
        ;;

esac

cd "${pwd}"
