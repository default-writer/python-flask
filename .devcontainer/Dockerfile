#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------

# This Dockerfile adds a non-root user with sudo access. Update the “remoteUser” property in
# devcontainer.json to use it. More info: https://aka.ms/vscode-remote/containers/non-root-user.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Options for common setup script - SHA updated on release
ARG INSTALL_ZSH="true"
ARG UPGRADE_PACKAGES="false"
ARG COMMON_SCRIPT_SOURCE="https://raw.githubusercontent.com/microsoft/vscode-dev-containers/main/script-library/common-debian.sh"
ARG COMMON_SCRIPT_SHA="dev-mode"
ARG PACKAGES_ALREADY_INSTALLED="true"

#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Artur Mustafin
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------

ARG IMAGE_TYPE=bitnami/minideb:latest
ARG PACKAGES_LIST="python3 python3-dev python3-venv"

FROM $IMAGE_TYPE as base

ENV PACKAGES_ALREADY_INSTALLED=${PACKAGES_ALREADY_INSTALLED}

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
RUN apt update -y \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt install -y --no-install-recommends curl ca-certificates ${PACKAGES_LIST} 2>&1 \
    && curl -sSL  ${COMMON_SCRIPT_SOURCE} -o /tmp/common-setup.sh \
    && ([ "${COMMON_SCRIPT_SHA}" = "dev-mode" ] || (echo "${COMMON_SCRIPT_SHA} */tmp/common-setup.sh" | sha256sum -c -)) \
    && /bin/bash /tmp/common-setup.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" \
    && rm /tmp/common-setup.sh \
    #
    # *********************************************************************
    # * Uncomment this section to use RUN to install other dependencies.  *
    # * See https://aka.ms/vscode-remote/containers/dockerfile-run        *
    # *********************************************************************
    # && apt -y install --no-install-recommends protobuf-compiler \
    #
    apt upgrade -y && \
    # Clean up
    && apt autoremove -y \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/* \
    apt autoclean -y && \
    rm -rf /var/lib/{cache,log}/ && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /usr/share/doc/ && \
    rm -rf /usr/share/man/ && \
    rm -rf /var/lib/apt/lists/*\
    rm -rf /tmp/*

USER ${USERNAME}
WORKDIR /workspace

COPY --chown=${USERNAME} . .
