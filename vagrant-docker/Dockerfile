FROM ssh

MAINTAINER Guillaume Verger (guillaume.verger@inria.fr)

RUN echo 'deb http://http.debian.net/debian/ jessie contrib' \
  >> /etc/apt/sources.list

RUN apt-get update

RUN apt-get install wget virtualbox -y

RUN wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.5.1_x86_64.deb
RUN dpkg --install vagrant_1.5.1_x86_64.deb
RUN rm -f vagrant_1.5.1_x86_64.deb
