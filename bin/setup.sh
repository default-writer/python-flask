#!/usr/bin/env bash
set -e

uid=$(id -u)

if [ ! "${uid}" -eq 0 ]; then
    echo "Please run as root"
    exit
fi

pwd=$(pwd)

install="$1"

case "${install}" in

    "--llvm") # installs llvm and llvm-cov
        apt -y update
        DEBIAN_FRONTEND=noninteractive apt -y install llvm
        apt -y upgrade
        ;;

    "--zsh") # installs zsh
        apt -y update
        DEBIAN_FRONTEND=noninteractive apt -y install zsh
        apt -y upgrade
        chsh -s $(which bash)
        ;;

    "--gh") # installs gh
        apt -y update
        type -p curl >/dev/null || apt install curl -y
        curl --silent -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/shar\(e/keyrings/githubcli-archive-keyring.gpg \
        && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
        && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
        && apt -y update
        DEBIAN_FRONTEND=noninteractive apt install gh -y
        apt -y upgrade
        ;;

    "--git") # install git
        apt -y update
        apt -y install git
        apt -y upgrade
        ;;

    "--pyenv") # installs pyenv
        apt -y update
        DEBIAN_FRONTEND=noninteractive apt -y install build-essential
        apt -y install --only-upgrade apport apport-gtk python3-apport python3-problem-report
        apt -y upgrade
        ;;

    "--python") # installs python
        apt -y update
        DEBIAN_FRONTEND=noninteractive apt -y install build-essential curl git ca-certificates python3 python3-dev python3-pip python3-venv python3-behave python3-virtualenv
        apt -y install --only-upgrade apport apport-gtk python3-apport python3-problem-report
        apt -y upgrade
        ;;

    "--cmake") # installs cmake
        apt -y update
        DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends curl ca-certificates git build-essential lldb lcov cmake clangd g++ gcc gdb lcov ninja-build
        apt -y upgrade
        ;;

    "--docker") # installs docker
        apt -y update
        DEBIAN_FRONTEND=noninteractive apt -y install ca-certificates curl gnupg lsb-release
        mkdir -p /etc/apt/keyrings
        curl --silent -fsSL --use-ascii --retry 5 --retry-all-errors https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null
        apt -y update
        chmod a+r /etc/apt/keyrings/docker.gpg
        apt -y update
        apt -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
        apt -y upgrade
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
