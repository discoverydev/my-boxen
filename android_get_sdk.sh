#!/bin/bash 

USER=ga-mlsdiscovery
SERVER=192.168.8.36 # mystique

source ~/.profile

echo "* adding ${SERVER} to known_hosts"
ssh-keyscan ${SERVER} > ~/.ssh/known_hosts

ANDROID_SDK=android-sdk
TARFILE=${ANDROID_SDK}.tar.gz
DESTINATION=/opt
SRC=/Users/${USER}/tailored_backup
ANDROID_SDK=android-sdk

echo "* copy ${TARFILE} from ${SERVER} (${SRC}) to ${DESTINATION}"

mkdir -p ${DESTINATION}

pushd ${DESTINATION}
echo "  user ${USER}"
if [[ -e ${DESTINATION}/${ANDROID_SDK} ]]; then
    echo "Android SDK detected - updating from gold image"
    echo "remove /opt/android-sdk to force a full redownload of the SDK."
    rsync -au --progress ${USER}@${SERVER}:${SRC}/${ANDROID_SDK} ${DESTINATION}/${ANDROID_SDK}
else 
    echo "No Android SDK detected - cloning from gold image"
    echo "rsync --progress ${USER}@${SERVER}:${SRC}/${TARFILE} ${DESTINATION}/${TARFILE} "
    rsync --progress ${USER}@${SERVER}:${SRC}/${TARFILE} ${DESTINATION}/${TARFILE} 

    tar xzkvf ${TARFILE}
fi

popd

HAXM_DIR="/opt/android-sdk/extras/intel/Hardware_Accelerated_Execution_Manager"

if [ ! 'kextstat | grep intel' ]; then
    sudo ${HAXM_DIR}/silent_install.sh
fi
