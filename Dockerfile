# Ubuntu
#
# VERSION               0.1

FROM ubuntu:latest
MAINTAINER Allisson Azevedo <allisson@gmail.com>

# avoid debconf and initrd
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# apt config
ADD source.list /etc/apt/sources.list
ADD 25norecommends /etc/apt/apt.conf.d/25norecommends

# avoid upgrade error
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl
ADD policy-rc.d /usr/sbin/policy-rc.d
RUN dpkg-divert --divert /usr/bin/ischroot.debianutils --rename /usr/bin/ischroot
RUN ln -s /bin/true /usr/bin/ischroot

# upgrade distro
RUN apt-get update && apt-get upgrade -y
RUN locale-gen en_US
RUN apt-get install lsb-release -y

# clean packages
RUN apt-get clean
RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
