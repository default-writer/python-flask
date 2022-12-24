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

    "--env") # installs env variables ('. ./install.sh env')
        user=$(id -un)
        id=$(id -u)
        group=$(id -gn)
        USER_NAME=${USER_NAME:-$user}
        USER_GROUP=${USER_GROUP:-$group}
        USER_ID=${USER_ID:-$id}
        export USER_NAME=${USER_NAME}
        export USER_GROUP=${USER_GROUP}
        export USER_ID=${USER_ID}
        ;;

    "--git") # installs git variables
        git config --global --add safe.directory "${pwd}"
        git config --global pull.rebase false
        ;;

    "--hooks") # installs git hooks
        cp "${pwd}/.hooks/prepare-commit-msg" "${pwd}/.git/hooks/prepare-commit-msg"
        chmod u+x "${pwd}/.git/hooks/prepare-commit-msg"
        ;;

    "--pyenv") # downloads and installs pyenv
        rm -rf "${HOME}/.pyenv"
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
