# syntax=docker/dockerfile:1
FROM ubuntu:22.04 as base

ARG USER_NAME=vscode
ARG USER_GROUP=vscode
ARG USER_ID=1000
ARG USER_GID=$USER_ID

# Options for common setup script - SHA generated on release
ARG INSTALL_ZSH="true"
ARG UPGRADE_PACKAGES="true"
ARG COMMON_SCRIPT_SOURCE="https://raw.githubusercontent.com/microsoft/vscode-dev-containers/master/script-library/common-debian.sh"
ARG COMMON_SCRIPT_SHA="dev-mode"

ENV TZ=Etc/UTC
RUN groupadd -r ${USER_GROUP} && useradd -ms /bin/bash -g ${USER_GROUP} -G sudo -u ${USER_ID} ${USER_NAME}


#ARG BUILD_LIST="curl build-essential ca-certificates git g++ gcc gdb lldb lcov cmake clangd ninja-build
ARG BUILD_LIST="curl ca-certificates locales locales-all sudo git ssh libssl-dev libffi-dev build-essential" 
ARG PACKAGES_LIST="python3 python3-pip python3-dev python3-venv python3-behave"

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
RUN apt -y update \
    && \apt -y install --no-install-recommends ${BUILD_LIST} ${PACKAGES_LIST} 2>&1 && \
    curl -sSL  ${COMMON_SCRIPT_SOURCE} -o /tmp/common-setup.sh && \
    ([ "${COMMON_SCRIPT_SHA}" = "dev-mode" ] || (echo "${COMMON_SCRIPT_SHA} /tmp/common-setup.sh" | sha256sum -c -)) && \
    /bin/bash /tmp/common-setup.sh "${INSTALL_ZSH}" "${USER_NAME}" "${USER_ID}" "${USER_GID}" "${UPGRADE_PACKAGES}" && \
    apt -y upgrade && \
    # Clean up
    apt autoclean -y && \
    apt autoremove -y && \
    rm -rf /var/lib/{cache,log}/ && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /usr/share/doc/ && \
    rm -rf /usr/share/man/ && \
    rm -rf /var/lib/apt/lists/* /tmp/common-setup.sh

USER ${USER_NAME}
WORKDIR /workspace
COPY --chown=${USER_NAME}:${USER_GROUP} . .

FROM base as init
RUN bash /workspace/bin/init.sh
