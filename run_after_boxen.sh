#!/bin/bash

USER=ga-mlsdiscovery
SERVER=192.168.8.36 # mystique

source ~/.profile

echo "* adding $SERVER to known_hosts"
ssh-keyscan $SERVER > ~/.ssh/known_hosts

TARFILE=tailored_backup.tar.gz
DESTINATION=/opt/
SRC=/Users/$USER/tailored_backup

echo "* copy $TARFILE from $SERVER ($SRC) to $DESTINATION"
mkdir -p $DESTINATION

pushd $DESTINATION
echo "  user $USER"
rsync -ru --progress $USER@$SERVER:$SRC/$TARFILE $DESTINATION/$TARFILE
tar xzkvf $TARFILE
popd

echo "* create android virtual devices"
gmtool admin create "Google Nexus 5 - 5.0.0 - API 21 - 1080x1920" Nexus_5_API_21_x86

echo "* run and configure android virtual devices"
gmtool admin start Nexus_5_API_21_x86

