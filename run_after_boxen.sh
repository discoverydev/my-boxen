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

HAXM_DIR="/opt/android-sdk/extras/intel/Hardware_Accelerated_Execution_Manager"
sudo ${HAXM_DIR}/silent_install.sh

android update sdk -a -u -t "sys-img-x-86-android-21" # 81
android update sdk -a -u -t "extra-intel-Hardware_Accelerate_Execution_Manager" # 153

android create avd --name Nexus_5_API_21_TEST -t android-21 -b default/x86 -f  

emulator @Nexus_5_API_21_TEST
