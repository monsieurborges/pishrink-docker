FROM ubuntu:24.10

LABEL maintainer="Monsieur Borges"
LABEL version="1.0.0"
LABEL date="2024-07-15"

# ADD Installation Scripts
###########################################################
ADD ./scripts/pishrink.sh /usr/local/bin/pishrink

# Improve Terminal (make sure things are pretty)
###########################################################
ENV SHELL=/bin/bash
ENV LANG=C.UTF-8
ENV TERM=xterm-256color
ENV DEBIAN_FRONTEND=noninteractive

# Create a new Docker Image
###########################################################
WORKDIR /workdir

RUN apt-get update && \
    # Install dependencies
    #----------------------------------------------------------
    apt-get --yes --quiet dist-upgrade\
    && apt-get install --yes --quiet --no-install-recommends \
        wget \
        parted \
        gzip \
        pigz \
        xz-utils \
        udev \
    # Install dependencies
    #----------------------------------------------------------
    && chmod +x /usr/local/bin/pishrink \
    # Improve Terminal
    #----------------------------------------------------------
    && cp /etc/skel/.bashrc ~/ \
    && sed -ri 's/^#force_color_prompt=yes/force_color_prompt=yes/' ~/.bashrc \
    # Cleanup
    #----------------------------------------------------------
    && rm -rf ~/.cache/* \
    && rm -rf /var/lib/apt/lists/*

# Build and Run
###########################################################
# docker build --rm --tag "monsieurborges/pishrink:latest" .
