FROM mcr.microsoft.com/devcontainers/universal:2
USER root

# Install Renode dependencies and ARM Toolchain
RUN apt-get update && apt-get install -y \
    gcc-arm-none-eabi \
    libnewlib-arm-none-eabi \
    python3-pip \
    wget \
    gnupg

# Install Renode
RUN wget https://builds.antmicro.com/renode/renode_1.15.3_amd64.deb && \
    apt-get install -y ./renode_1.15.3_amd64.deb && \
    rm renode_1.15.3_amd64.deb

# Install Robot Framework for the exploit automation
RUN pip3 install robotframework-renode
