FROM ubuntu:xenial

ARG PLASO_REVISION

######################
# Install basic deps #
######################
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y build-essential \
  autotools-dev \
  libsqlite3-dev \
  python-dev \
  debhelper \
  devscripts \
  fakeroot \
  quilt \
  git \
  mercurial \
  python-setuptools \
  libtool \
  automake \
  libyaml-dev \
  software-properties-common \
  wget \
  sudo

#####################################
# Add GIFT dev PPA and install deps #
#####################################
RUN add-apt-repository ppa:gift/dev
RUN mkdir install
WORKDIR install
# We do this because $PLASO_SRC is likely not to be in the build context, so it makes more sense to not rely on that
RUN wget https://raw.githubusercontent.com/log2timeline/plaso/${PLASO_REVISION}/config/linux/gift_ppa_install.sh
RUN chmod 775 ./gift_ppa_install.sh
RUN ./gift_ppa_install.sh include-development incluide-test include-debug

#############################
# Install Development Tools #
#############################
RUN apt-get install -y python-pip
RUN pip install --upgrade pip
RUN pip install wrapt
RUN pip install lazy-object-proxy
# logilab-common
RUN apt-get install -y python3-all \
  python3-setuptools \
  python-epydoc \
  graphviz \
  python-unittest2 \
  python-egenix-mxdatetime \
  python3-tz
RUN hg clone http://hg.logilab.org/logilab/common
RUN cd common && dpkg-buildpackage -rfakeroot
# python-astroid
## python-support needed for astroid
RUN wget http://launchpadlibrarian.net/109052632/python-support_1.0.15_all.deb
RUN dpkg -i python-support_1.0.15_all.deb
RUN hg clone https://bitbucket.org/logilab/astroid
RUN cd astroid && dpkg-buildpackage -rfakeroot
# pylint
RUN hg clone https://bitbucket.org/logilab/pylint
RUN cd pylint && dpkg-buildpackage -rfakeroot
# install
RUN sudo dpkg -i python-logilab-common_1.4.1-1_all.deb python-astroid_1.3.4-1_all.deb pylint_1.4.1-1_all.deb
# python-mock
RUN apt-get -y install python-mock

####################################
# Set terminal to UTF-8 by default #
####################################
RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

#####################
# Set final workdir #
#####################
WORKDIR /root/plaso
