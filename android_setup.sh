#!/bin/bash

USER=ga-mlsdiscovery
SERVER=192.168.8.36 # mystique

source ~/.profile

echo "* adding ${SERVER} to known_hosts"
ssh-keyscan ${SERVER} > ~/.ssh/known_hosts

TARFILE=tailored_backup.tar.gz
DESTINATION=/opt
SRC=/Users/${USER}/tailored_backup

if [[ $1 == '--copy-sdk' ]]; then
    echo "* copy ${TARFILE} from ${SERVER} (${SRC}) to ${DESTINATION}"

    mkdir -p ${DESTINATION}
    
    pushd ${DESTINATION}
    echo "  user ${USER}"
    rsync -ru --progress ${USER}@${SERVER}:${SRC}/${TARFILE} ${DESTINATION}/${TARFILE}
    tar xzkvf ${TARFILE}
    popd
    
    HAXM_DIR="/opt/android-sdk/extras/intel/Hardware_Accelerated_Execution_Manager"
    sudo ${HAXM_DIR}/silent_install.sh
fi

get_android_pkg(){
    # gets the id number of the pkg - necessary because they change
    local pkg_id=$(android list sdk --all -e | grep $1 | cut -d ' ' -f 2)   
    echo 'y' | android update sdk -a -u -t ${pkg_id}
}

get_android_pkg 'sys-img-x86_64-google_apis-21'
get_android_pkg 'extra-intel-Hardware_Accelerated_Execution_Manager'

AVD_NAME='Nexus_5_API_21_Test_Device'
AVD_PATH='/Users/${USER}/.android/avd/${AVD_NAME}' 

rm -f '${AVD_PATH}.ini'
rm -rf '${AVD_PATH}.avd'

echo 'no' | android create avd --name Nexus_5_API_21_Test_Device -t android-21 -b default/x86 -f  

cp ${DESTINATION}/android-sdk/test_device_config.ini /Users/${USER}/.android/avd/Nexus_5_API_21_Test_Device.avd/config.ini 

android list avds
