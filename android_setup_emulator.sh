#!/bin/bash

DESTINATION="/opt"
USER="ga-mlsdiscovery"

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
