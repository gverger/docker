#! /bin/bash

# image : absolute path
image=$(readlink -fn "$1")
name=$(basename "$image")
path=${image%/*}

echo image = $image
echo name = $name
echo path = $path
tmp_dir=/tmp/docker
mkdir -p $tmp_dir
keyfile=$tmp_dir/id_rsa
rm -f $keyfile

id=$(docker run -d -P --privileged -p 5901:5901 -v $tmp_dir:/key\
      -v $path:/sync qemu  /usr/sbin/sshd -D )
ssh_port=$(docker port $id 22)
ssh_port=${ssh_port##*:}

while [ ! -f "$keyfile" ]; do
  inotifywait -qqt 2 -e create -e moved_to "$(dirname $keyfile)"
done

ssh_cmd="ssh root@localhost -p $ssh_port -i $keyfile -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no "

sleep 1
nohup $ssh_cmd "kvm /sync/$name -vnc :1 -k fr" &

echo "You can connect to docker hypervisor with $ssh_cmd"
echo "You can access to the virtual machine with vncviewer localhost:1"
echo "Stop the docker execution with docker stop $id"
#docker run --rm --privileged -p 5901:5901 -i -t -v $path:/sync qemu kvm /sync/$name -vnc :1 -k fr

