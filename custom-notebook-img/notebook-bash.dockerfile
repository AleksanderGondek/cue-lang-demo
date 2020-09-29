FROM jupyter/minimal-notebook@sha256:14a99ba37d5567607a492d05b932740a98b6c36864097b2c858cb0934719a559

USER $NB_UID
ENV USER=$NB_USER

RUN pip install --no-cache-dir bash_kernel==0.7.1
RUN python -m bash_kernel.install
COPY populate_home_with_notebooks.sh /usr/local/bin
