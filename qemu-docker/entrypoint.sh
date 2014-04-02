#!/bin/bash
# Docker entrypoint that does runtime setup of the container environment for KVM,
# before running the user-specified command.

/root/qemu/kvm-mknod.sh

KEYGEN=/usr/bin/ssh-keygen
KEYFILE=/root/.ssh/id_rsa

if [ ! -f $KEYFILE ]; then
  $KEYGEN -q -t rsa -N "" -f $KEYFILE
  cat $KEYFILE.pub >> /root/.ssh/authorized_keys
fi

echo "== Use this private key to log in =="
cat $KEYFILE
cat $KEYFILE > /key/id_rsa
exec "$@"
