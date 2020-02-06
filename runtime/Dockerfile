ARG SRC_IMAGE

FROM ${SRC_IMAGE}
LABEL maintainer="Davide De Tommaso <dtmdvd@gmail.com>"

ARG USER
ARG LOCAL_USER_ID

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN useradd -ms /bin/bash -u $LOCAL_USER_ID ${USER}
RUN usermod -g root -G audio ${USER}
RUN echo "${USER}:${USER}" | chpasswd

RUN LC_ALL=en_US.UTF-8

RUN apt-get update

RUN apt-get install -y \
    apt-utils \
    libusb-1.0-0-dev \
    portaudio19-dev \
    libasound2-dev \
    git \
    locales locales-all \
    pkg-config \
    libcairo2 \
    libcairo2-dev \
    freeglut3-dev \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    libx11-dev \
    x11proto-render-dev \
    libx11-xcb1 \
    mesa-common-dev \
    mesa-utils \
    qt5-default \
    wget;

RUN apt-get update

RUN apt-get install -y \
    ca-certificates cron dbus dirmngr distro-info-data file gir1.2-glib-2.0 \
    gnupg gnupg-l10n gnupg-utils gpg gpg-agent gpg-wks-client gpg-wks-server \
    gpgconf gpgsm iso-codes libapparmor1 libapt-inst2.0 libasn1-8-heimdal \
    libassuan0 libdbus-1-3 libexpat1 libgirepository-1.0-1 libglib2.0-0 \
    libglib2.0-data libgssapi3-heimdal libhcrypto4-heimdal libheimbase1-heimdal \
    libheimntlm0-heimdal libhx509-5-heimdal libicu60 libkrb5-26-heimdal libksba8 \
    libldap-2.4-2 libldap-common libmagic-mgc libmagic1 libmpdec2 libnpth0 \
    libpython3-stdlib libpython3.6-minimal libpython3.6-stdlib libreadline7 \
    libroken18-heimdal libsasl2-2 libsasl2-modules libsasl2-modules-db \
    libsqlite3-0 libssl1.1 libwind0-heimdal libxml2 lsb-release mime-support \
    openssl pinentry-curses powermgmt-base \
    readline-common shared-mime-info \
    software-properties-common ucf unattended-upgrades xdg-user-dirs xz-utils \
    pyqt5.qsci-dev \
    python-apt-common \
    python3 \
    python3.6 \
    python3.6-minimal \
    python3-dbus \
    python3-gi \
    python3-minimal \
    python3-software-properties \
    python3-apt \
    python3-pyqt5.qsci \
    python3-pyqt5.qtwebkit \
    python3-setuptools \
    python3-pip \
    python3-wxgtk4.0 \
    python3-wxgtk-webview4.0 python3-wxgtk-media4.0 \
    python3-webcolors \
    python3-opencv \
    python3-pyaudio \
    python3-qtconsole \
    ipython3 \
    ipython3-qtconsole \
    x11-xserver-utils xinit xserver-xorg-video-dummy xserver-xorg-input-void websockify ffmpeg \
    zip unzip;

ENV PATH=${PATH}:/home/${USER}/.local/bin

USER ${USER}
# python-qnotifications requires qtpy in advance, that's why pip3 two times
# pyyaml needs to be older than 5.1 - otherwise you will get ConstructorError on startup
#  (yes, 3.13 is actually just before 5.1)
RUN pip3 install --upgrade --user setuptools pip
RUN python3 -m pip install --user QtPy QScintilla python-qprogedit python-datamatrix pyyaml==3.13
RUN python3 -m pip install --user python-qdatamatrix python-pseudorandom python-qnotifications expyriment \
                                  numpy pillow pyflakes pyopengl pyserial markdown ipython python-fileinspector \
                                  shapely matplotlib scipy cryptography==2.8 pyglet==1.3.2 python-qprogedit python-datamatrix \
                                  pycairo pyparallel python-pygaze pyqtwebengine pygame

RUN python3 -m pip install --user psychopy==3.0.6
# psychopy must use the system pyqt5 libs, otherwise will segfault:
RUN python3 -m pip uninstall -y PyQt5

RUN cd /home/${USER} && \
  wget https://github.com/s4hri/OpenSesame/archive/release/3.2.8-Py3.6.tar.gz && \
  tar xvf 3.2.8-Py3.6.tar.gz && \
  cd OpenSesame-release-3.2.8-Py3.6 && \
  python3 -m pip install --user .

RUN python3 -m pip install --user mediadecoder
RUN python3 -m pip install --user opensesame-plugin-media_player_mpy
RUN sed -i 's/unicode/str/g' /home/${USER}/.local/share/opensesame_plugins/media_player_mpy/media_player_mpy.py

USER ${USER}
WORKDIR /home/${USER}/exp
ENTRYPOINT ["opensesame"]
