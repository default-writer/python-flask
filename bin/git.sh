#!/usr/bin/env bash
set -e

uid=$(id -u)

pwd=$(pwd)

install="$1"

case "${install}" in

    "--git") # installs git variables
        git config --global --add safe.directory "${pwd}"
        git config --global pull.rebase false
        ;;

    "--hooks") # installs git hooks
        cp "${pwd}/.hooks/prepare-commit-msg" "${pwd}/.git/hooks/prepare-commit-msg"
        chmod u+x "${pwd}/.git/hooks/prepare-commit-msg"
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
