#!/bin/bash

#USER=ga-mlsdiscovery
USER=ga-mlsdiscovery
SERVER=192.168.8.36

source ~/.profile

echo "* adding $SERVER to known_hosts"
ssh-keyscan $SERVER > ~/.ssh/known_hosts

TARFILE=tailored_backup.tar
DEST=/opt/android-sdk
SRC=/Users/$USER/tailored_backup

echo "* copy $TARFILE from $SERVER ($SRC) to $DEST"
mkdir -p $DEST

pushd $DEST
echo "  user $USER"
rsync -ru --progress $USER@$SERVER:$SRC/$TARFILE $DEST/$TARFILE
tar xzkvf $TARFILE
popd

echo "* create android virtual devices"
gmtool admin create "Google Nexus 5 - 5.0.0 - API 21 - 1080x1920" Nexus_5_API_21_x86

echo "* run and configure android virtual devices"
gmtool admin start Nexus_5_API_21_x86

