FROM ubuntu:18.04

ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
  apt-get install -y git && \
  apt-get install -y ca-certificates cron dbus dirmngr distro-info-data file gir1.2-glib-2.0 \
  gnupg gnupg-l10n gnupg-utils gpg gpg-agent gpg-wks-client gpg-wks-server \
  gpgconf gpgsm iso-codes libapparmor1 libapt-inst2.0 libasn1-8-heimdal \
  libassuan0 libdbus-1-3 libexpat1 libgirepository-1.0-1 libglib2.0-0 \
  libglib2.0-data libgssapi3-heimdal libhcrypto4-heimdal libheimbase1-heimdal \
  libheimntlm0-heimdal libhx509-5-heimdal libicu60 libkrb5-26-heimdal libksba8 \
  libldap-2.4-2 libldap-common libmagic-mgc libmagic1 libmpdec2 libnpth0 \
  libpython3-stdlib libpython3.6-minimal libpython3.6-stdlib libreadline7 \
  libroken18-heimdal libsasl2-2 libsasl2-modules libsasl2-modules-db \
  libsqlite3-0 libssl1.1 libwind0-heimdal libxml2 lsb-release mime-support \
  openssl pinentry-curses powermgmt-base python-apt-common python3 python3-apt \
  python3-dbus python3-gi python3-minimal python3-software-properties \
  python3.6 python3.6-minimal readline-common shared-mime-info \
  software-properties-common ucf unattended-upgrades xdg-user-dirs xz-utils

RUN git config --global user.name User Name
RUN git config --global user.email totalna.glupota@gmail.com

RUN apt-get install -y python3-setuptools
RUN apt-get install -y python3-pip

RUN apt-get install -y ipython3 ipython3-qtconsole python3-qtconsole
# RUN apt-get install -y python3-pyqt5.qsci python3-qtpy

RUN pip3 install QtPy PyQt5 QScintilla python-qprogedit python-datamatrix

RUN pip3 install python-qprogedit python-datamatrix

RUN apt-get install -y libgl1-mesa-glx
RUN pip3 install python-qdatamatrix python-pseudorandom python-qnotifications expyriment \
  numpy pillow pyflakes pyglet pyopengl pyserial markdown ipython python-fileinspector \
  shapely matplotlib scipy
RUN apt-get install -y pkg-config
RUN apt-get install -y libcairo2 libcairo2-dev
RUN apt-get install -y libx11-dev x11proto-render-dev
RUN pip3 install pycairo pyparallel python-pygaze pyqtwebengine
RUN pip3 install pygame

RUN apt-get install -y python3-wxgtk4.0 python3-wxgtk-webview4.0 python3-wxgtk-media4.0 \
  python3-webcolors python3-opencv python3-pyaudio

RUN apt-get install -y libx11-xcb1 qt5-default
RUN apt-get install -y mesa-common-dev mesa-utils

RUN apt-get install -y wget unzip

# ENV LANG en_GB.UTF-8
# ENV LC_CTYPE "en_US.UTF-8"
# ENV LC_NUMERIC "en_GB.UTF-8"
# ENV LC_TIME "en_GB.UTF-8"
# ENV LC_COLLATE "en_GB.UTF-8"
# ENV LC_MONETARY "en_GB.UTF-8"
# ENV LC_MESSAGES "en_GB.UTF-8"

# ENV PYTHONIOENCODING UTF-8
ENV LANG C.UTF-8

RUN pip3 install psychopy

RUN cd /root && \
  wget https://github.com/smathot/OpenSesame/archive/release/3.2.8.tar.gz && \
  tar xvf 3.2.8.tar.gz && \
  cd OpenSesame-release-3.2.8 && \
  cd opensesame_resources/theme/default && \
  wget http://forum.cogsci.nl/uploads/editor/we/p1y3i4qm70ch.zip && \
  unzip p1y3i4qm70ch.zip && \
  rm p1y3i4qm70ch.zip && \
  cd ../../.. && \
  mv opensesame_resources/backend_info.yaml opensesame_resources/backend_info.yaml1 && \
  sed 's/py3: false/py3: true/' opensesame_resources/backend_info.yaml1 > opensesame_resources/backend_info.yaml && \
  pip3 install .
#  python3 setup.py build

RUN apt-get install -y binutils kmod
ADD nvidia.run /tmp/nvidia.run
RUN sh /tmp/nvidia.run -s -N --ui=none --no-kernel-module

# RUN apt-get install -y libgl1-mesa-dri x11-xserver-utils xinit   xserver-xorg-video-dummy   xserver-xorg-input-void websockify

RUN useradd -ms /bin/bash user
ENV DISPLAY :0
USER user

ENTRYPOINT ["opensesame"]