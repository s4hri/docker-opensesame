FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04
LABEL maintainer="Davide De Tommaso <dtmdvd@gmail.com>"

COPY requirements/deb-pkgs/*.deb /root/

RUN cd /root && \
    apt-get update && \
    dpkg -i python-datamatrix_0.10.3-1_all.deb || true && \
    dpkg -i python-qdatamatrix_0.1.18-1_all.deb || true && \
    dpkg -i python-qprogedit_4.1.2-1_all.deb || true && \
    dpkg -i python-qnotifications_2.0.2-1_all.deb || true && \
    dpkg -i python-pseudorandom_0.2.2-1_all.deb || true && \
    dpkg -i python-fileinspector_1.0.2-1_all.deb || true && \
    dpkg -i opensesame_3.2.8+b1-1_all.deb || true && \
    apt-get -f install -y && \
    apt-get install -y portaudio19-dev python-pyaudio freeglut3-dev;

COPY requirements/pip_pkgs.txt /root/

RUN cd /root && \
    apt-get update && \
    apt-get install -y python-pip && \
    pip install -r pip_pkgs.txt;

ENTRYPOINT ["opensesame"]
