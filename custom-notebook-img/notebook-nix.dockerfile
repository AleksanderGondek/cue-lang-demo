FROM aleksandergondek/jupyter-docker-stacks:bash

USER root
RUN apt-get update && apt-get install -yq --no-install-recommends \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN mkdir /nix
RUN chown $NB_UID:users /nix
RUN curl https://nixos.org/nix/install > install.sh && bash ./install.sh --no-daemon

USER $NB_UID
ENV USER=$NB_USER
COPY populate_home_with_nix.sh /usr/local/bin
