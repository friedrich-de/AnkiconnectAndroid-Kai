FROM mcr.microsoft.com/devcontainers/java:1-17-bookworm

ARG ANDROID_COMMANDLINE_TOOLS_VERSION=14742923
ARG ANDROID_PLATFORM=android-33
ARG ANDROID_BUILD_TOOLS_VERSION=35.0.0
ARG ANDROID_HOME=/opt/android-sdk

ENV ANDROID_HOME=${ANDROID_HOME} \
    ANDROID_SDK_ROOT=${ANDROID_HOME} \
    DEBIAN_FRONTEND=noninteractive

ENV PATH=${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/build-tools/${ANDROID_BUILD_TOOLS_VERSION}:${PATH}

USER root

RUN rm -f /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        libncurses6 \
        libstdc++6 \
        lsb-release \
        openssh-client \
        procps \
        unzip \
        zip \
        zlib1g \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p "${ANDROID_HOME}/cmdline-tools" \
    && curl -fsSL "https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_COMMANDLINE_TOOLS_VERSION}_latest.zip" \
        -o /tmp/android-commandline-tools.zip \
    && unzip -q /tmp/android-commandline-tools.zip -d /tmp/android-sdk-tools \
    && mv /tmp/android-sdk-tools/cmdline-tools "${ANDROID_HOME}/cmdline-tools/latest" \
    && rm -rf /tmp/android-commandline-tools.zip /tmp/android-sdk-tools \
    && yes | sdkmanager --sdk_root="${ANDROID_HOME}" --licenses >/dev/null \
    && sdkmanager --sdk_root="${ANDROID_HOME}" \
        "platform-tools" \
        "platforms;${ANDROID_PLATFORM}" \
        "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
    && printf '%s\n' \
        "export ANDROID_HOME=${ANDROID_HOME}" \
        "export ANDROID_SDK_ROOT=${ANDROID_HOME}" \
        "export PATH=${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/build-tools/${ANDROID_BUILD_TOOLS_VERSION}:\${PATH}" \
        > /etc/profile.d/android-sdk.sh \
    && mkdir -p /home/vscode/.codex-sqlite \
    && chown -R vscode:vscode /home/vscode/.codex-sqlite \
    && chown -R vscode:vscode "${ANDROID_HOME}"

USER vscode
