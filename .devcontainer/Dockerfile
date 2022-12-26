FROM ubuntu:22.04

ARG USER=vscode
ARG GROUP=vscode
ARG ID=1000

# Options for common setup script - SHA generated on release
# ARG INSTALL_ZSH="true"
# ARG UPGRADE_PACKAGES="true"
# ARG COMMON_SCRIPT_SOURCE="https://raw.githubusercontent.com/microsoft/vscode-dev-containers/master/script-library/common-debian.sh"
# ARG COMMON_SCRIPT_SHA="dev-mode"
# ENV TZ=Etc/UTC

RUN apt update -y && \
    # export DEBIAN_FRONTEND=noninteractive && \
    # TZ=Etc/UTC apt -y install tzdata && \
    # ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    groupadd -f ${GROUP} && useradd -ms /bin/bash -g ${GROUP} -G sudo -u ${ID} ${USER} && \
    # DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends curl build-essential ca-certificates git python3 python3-pip python3-venv g++ gcc gdb lldb lcov cmake clangd ninja-build  zlib1g-dev libffi-dev libssl-dev libbz2-dev libreadline-dev libsqlite3-dev liblzma-dev python3-tk tk-dev 2>&1 && \
    # curl -sSL  ${COMMON_SCRIPT_SOURCE} -o /tmp/common-setup.sh && \
    # ([ "${COMMON_SCRIPT_SHA}" = "dev-mode" ] || (echo "${COMMON_SCRIPT_SHA} /tmp/common-setup.sh" | sha256sum -c -)) && \
    # /bin/bash /tmp/common-setup.sh "${INSTALL_ZSH}" "${USER}" "${ID}" "${ID}" "${UPGRADE_PACKAGES}" && \
    DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends python3 python3-pip python3-venv 2>&1 && \
    apt -y upgrade && \
    # Clean up
    apt autoclean -y && \
    apt autoremove -y && \
    rm -rf /var/lib/{cache,log}/ && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /usr/share/doc/ && \
    rm -rf /usr/share/man/ && \
    rm -rf /var/lib/apt/lists/*
    # rm -rf /tmp/common-setup.sh

# USER ${USER}
WORKDIR /workspace

COPY --chown=${USER}:${GROUP} . .
