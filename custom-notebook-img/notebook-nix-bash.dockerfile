FROM jupyter/minimal-notebook@sha256:ea37fe94e47691bbc7dd240d51d3ec1a99abde200b777c2868d6c278d106d75d

USER root

RUN apt-get update && apt-get install -yq --no-install-recommends \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /nix
RUN chown $NB_UID:users /nix

USER $NB_UID

ENV USER=$NB_USER

RUN curl https://nixos.org/nix/install > install.sh && bash ./install.sh --no-daemon
COPY populate_home.sh /etc/

RUN pip install --no-cache-dir bash_kernel==0.7.2 && python -m bash_kernel.install
