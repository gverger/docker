FROM ubuntu
MAINTAINER Guillaume Verger

RUN apt-get update -y
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' |chpasswd

EXPOSE 22
CMD    /usr/sbin/sshd -D
