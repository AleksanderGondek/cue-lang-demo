FROM jupyter/minimal-notebook@sha256:ea37fe94e47691bbc7dd240d51d3ec1a99abde200b777c2868d6c278d106d75d

USER $NB_UID
ENV USER=$NB_USER

RUN pip install --no-cache-dir bash_kernel==0.7.2 && python -m bash_kernel.install
COPY populate_home_with_notebooks.sh /usr/local/bin
