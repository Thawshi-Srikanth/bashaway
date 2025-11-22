FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install basic build essentials and tools
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*