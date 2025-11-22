FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install basic system essentials + git-lfs
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    git-lfs \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/* \
    && git lfs install