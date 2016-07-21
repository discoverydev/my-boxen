#!/bin/bash

USER=ga-mlsdiscovery
SERVER=192.168.8.36 # mystique

source ~/.profile

echo "* adding ${SERVER} to known_hosts"
ssh-keyscan ${SERVER} > ~/.ssh/known_hosts

TARFILE=tailored_backup.tar.gz
DESTINATION=/opt/
SRC=/Users/${USER}/tailored_backup

echo "* copy ${TARFILE} from ${SERVER} (${SRC}) to ${DESTINATION}"

mkdir -p ${DESTINATION}

pushd ${DESTINATION}
echo "  user ${USER}"
rsync -ru --progress ${USER}@${SERVER}:${SRC}/${TARFILE} ${DESTINATION}/${TARFILE}
tar xzkvf ${TARFILE}
popd

HAXM_DIR="/opt/android-sdk/extras/intel/Hardware_Accelerated_Execution_Manager"
sudo ${HAXM_DIR}/silent_install.sh

get_android_pkg(){
    # gets the id number of the pkg - necessary because they change
    local pkg_id=$(android list sdk --all -e | grep $1 | cut -d ' ' -f 2)   
    echo 'y' | android update sdk -a -u -t ${pkg_id}
}

get_android_pkg 'sys-img-x86-android-21'
get_android_pkg 'extra-intel-Hardware_Accelerated_Execution_Manager'

echo 'no' | android create avd --name Nexus_5_API_21_Test_Device -t android-21 -b default/x86 -f  

cp ${DESTINATION}android-sdk/test_device_config.ini /Users/${USER}/.android/avd/Nexus_5_API_21_Test_Device.avd/config.ini 

android list avds
