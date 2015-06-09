#!/bin/sh

echo "***** Initializing Stash"
echo "** boot2docker setup"
echo "* deleting any existing boot2docker images"
boot2docker down
boot2docker delete

echo "* initialize boot2docker"
boot2docker init

echo "* increasing boot2docker memory"
VBoxManage modifyvm boot2docker-vm --memory 8192
echo "* exposing stash port to the outside world"
VBoxManage modifyvm boot2docker-vm --natpf1 'stash-http-7990,tcp,,7990,,7990'
echo "* exposing nexus port to the outside world"
VBoxManage modifyvm boot2docker-vm --natpf1 'nexus-http-8081,tcp,,8081,,8081'
echo "* exposing jenkins port to the outside world"
VBoxManage modifyvm boot2docker-vm --natpf1 'jenkins-http-8080,tcp,,8080,,8080'

echo "** boot2docker startup"
boot2docker up --vbox-share=disable
$(boot2docker shellinit)
boot2docker ip

echo "* enable host nfs daemon for /Users"
echo "/Users -mapall=`whoami`:staff `boot2docker ip`" >> exports
sudo mv exports /etc && sudo nfsd restart
sleep 15

echo "* enable boot2docker nfs clent for /Users"
boot2docker ssh 'echo -e "#! /bin/bash\n\
sudo mkdir /Users
sudo chown docker:staff /Users
# start nfs client
sudo /usr/local/etc/init.d/nfs-client start\n\
# mount /Users to host /Users
sudo mount 192.168.59.3:/Users /Users -o rw,async,noatime,rsize=32768,wsize=32768,proto=tcp" > ~/bootlocal.sh'
boot2docker ssh 'sudo mv ~/bootlocal.sh /var/lib/boot2docker/'
boot2docker ssh 'ls -ltra /var/lib/boot2docker/'
boot2docker ssh '. /var/lib/boot2docker/bootlocal.sh'
echo "* display mounted nfs share"
boot2docker ssh mount
boot2docker ssh 'ls -ltra /Users'

echo "* define root for data shares (must be under the above nfs share)"
DATA_DIR=/Users/Shared/data
mkdir -p $DATA_DIR

echo "** docker stash startup"
if [ -f $1 ]
then
  echo "* unzipping $1 to stash"
  rm -rf $DATA_DIR/stash
  unzip $1 -d $DATA_DIR/stash
fi
mkdir -p $DATA_DIR/stash
docker run --name=stash -d -v $DATA_DIR/stash:/var/atlassian/application-data/stash -p 7990:7990 -p 7999:7999 atlassian/stash
docker ps

echo "** docker nexus startup"
mkdir -p $DATA_DIR/nexus
docker run --name nexus -d -v $DATA_DIR/nexus:/sonatype-work -p 8081:8081 sonatype/nexus 
docker ps

echo "** docker jenkins startup"
mkdir -p $DATA_DIR/jenkins
echo "* wait for stash to startup"
sleep 120 
echo "* clone jenkins config"
#todo
echo "* clone jenkins jobs"
#todo
docker run --name jenkins -d -v $DATA_DIR/jenkins:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins 
docker ps

echo "** open stash browser"
open http://localhost:7990/
echo "** open nexus browser"
open http://localhost:8081/
echo "** open jenkins browser"
open http://localhost:8080/
