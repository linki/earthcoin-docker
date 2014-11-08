# a container that runs an earthcoin node on mainnet
#
# build the container:
#   docker build -t linki/earthcoin .
#
# create and name a data container:
#   docker run -v /var/lib/earthcoin --name earthcoin-data busybox true
#
# run the earthcoin node:
#   docker run -d -p 15677:15677 --volumes-from earthcoin-data linki/earthcoin
#
# if you want to poke around in the container:
#   docker run -ti --rm --volumes-from earthcoin-data linki/earthcoin /bin/bash
#
# and don't forget on the host:
#
#   ufw allow 15677/tcp
#
# related resources:
#
#   https://github.com/phusion/baseimage-docker
#   https://help.ubuntu.com/14.04/serverguide/firewall.html
#   http://docs.docker.io/installation/ubuntulinux/#docker-and-ufw

FROM phusion/baseimage:0.9.15
MAINTAINER Linki <linki+docker.com@posteo.de>

# set the earthcoin version
ENV EAC_VERSION 1.3.1

# download and extract a released binary
RUN mkdir -p /tmp/earthcoin && \
    curl https://earthcoin.s3.amazonaws.com/releases/$EAC_VERSION/linux/earthcoin-$EAC_VERSION-linux.tar.gz | \
      tar -C /tmp/earthcoin -xz bin/64/earthcoind && \
    mv /tmp/earthcoin/bin/64/earthcoind /usr/local/bin && rm -rf /tmp/earthcoin

# keep earthcoind daemon running with runit
ADD earthcoind.sh /etc/service/earthcoind/run

# add config file from the outside
ADD earthcoin.conf /var/tmp/earthcoin.conf

# move config to linked data container after startup
ADD move_config.sh /etc/my_init.d/01_move_config.sh

# expose earthcoin's port
EXPOSE 25677
