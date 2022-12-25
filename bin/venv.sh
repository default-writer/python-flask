#!/usr/bin/env bash
set -e

uid=$(id -u)

if [ "${uid}" -eq 0 ]; then
    echo "Please run as user"
    exit
fi

pwd=$(pwd)

install="$1"

case "${install}" in

    "--nvm") # installs nvm
        if [ "$(which nvm)" == "" ]; then
            . "${pwd}/bin/nvm.sh"
            [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
            [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
            nvm install node
            nvm use node
            npm install -g npm@9.2.0
        fi
        ;;

    "--pyenv") # installs pyenv virtual environment for 3.11.1 into .venv folder
        if [ "$(which pyenv)" == "" ]; then
            . "${pwd}/bin/pyenv.sh"
            eval "$(pyenv init -)"
            eval "$(pyenv virtualenv-init -)"
            pyenv install -f 3.11.1
            pyenv virtualenv -f 3.11.1 .venv
            pyenv activate .venv
        fi
        ;;

    "--venv") # installs python3 venv virtual environment into .venv folder
        rm -rf .venv
        python3 -m venv .venv
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
