#!/usr/bin/env bash
set -e

pwd=$(pwd)

install="$1"

case "${install}" in

    "--nvm") # installs nvm variables
        curl --silent -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
        ;;

    "--pyenv") # downloads and installs pyenv
        rm -rf "$HOME/.pyenv"
        curl --silent https://pyenv.run | bash
        ;;

    *)
        commands=$(cat $0 | sed -e 's/^[ \t]*//;' | sed -e '/^[ \t]*$/d' | sed -n -e 's/^"\(.*\)".*#/    \1:/p' | sed -n -e 's/: /:\n        /p')
        script="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
        help=$(\
cat << EOF
Installs optional dependencies
Usage: ${script} <option>
${commands}
EOF
)
        echo "${help}"
        exit
        ;;

esac

cd "${pwd}"
