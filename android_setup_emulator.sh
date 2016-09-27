#!/bin/bash 

DESTINATION="/opt"
USER="ga-mlsdiscovery"
ANDROID_SDK_PATH="/opt/android-sdk"

get_android_platform(){
   local platform=$1
   local platform_path=${ANDROID_SDK_PATH}/platforms/${platform}
   
   get_android_pkg $platform $platform_path
}

get_android_pkg(){
    local pkg_name=$1
    local pkg_path=$2

    if [[ -z "$pkg_path" || ! -e "$pkg_path" ]]; then
        echo "Fetching $pkg_name"
        echo 'y' | android update sdk -a -u -t ${pkg_name}
        #get_android_pkg_by_name "$pkg_name"
    else 
        echo "Android Package ${pkg_name} already exists, not downloading."
        echo "You can delete ${pkg_path} to force an update." 
        echo
    fi
}

get_android_pkg_by_name(){
    # gets the id number of the pkg - necessary because they change
    local pkg_name="$1"
    # that extra \" in the grep is needed, not a mistake
    local pkg_id=$(android list sdk --all -e | grep \"${pkg_name} | cut -d ' ' -f 2)
    echo 'y' | android update sdk -a -u -t ${pkg_id}
}

get_android_platform 'android-16'
get_android_platform 'android-21'
get_android_platform 'android-23'
get_android_platform 'android-24'

get_android_pkg 'build-tools-23.0.3' "${ANDROID_SDK_PATH}/build-tools/23.0.3"
get_android_pkg 'build-tools-24.0.2' "${ANDROID_SDK_PATH}/build-tools/24.0.2"
get_android_pkg 'build-tools-24.0.1' "${ANDROID_SDK_PATH}/build-tools/24.0.1"
get_android_pkg 'source-23' "${ANDROID_SDK_PATH}/sources/android-23"
get_android_pkg 'source-24' "${ANDROID_SDK_PATH}/sources/android-24"

emu_16_img="sys-img-x86-google_apis-16"
emu_16_path="${ANDROID_SDK_PATH}/system-images/android-16/google_apis/x86/"
get_android_pkg $emu_16_img $emu_16_path 

emu_21_img="sys-img-x86_64-google_apis-21"
emu_21_path="${ANDROID_SDK_PATH}/system-images/android-21/google_apis/x86_64/"
get_android_pkg $emu_21_img $emu_21_path

emu_23_img="sys-img-x86_64-google_apis-23"
emu_23_path="${ANDROID_SDK_PATH}/system-images/android-23/google_apis/x86_64/"
get_android_pkg $emu_23_img $emu_23_path 

emu_24_img="sys-img-x86_64-google_apis-24"
emu_24_path="${ANDROID_SDK_PATH}/system-images/android-24/google_apis/x86_64/"
get_android_pkg $emu_24_img $emu_24_path

get_android_pkg 'extra-intel-Hardware_Accelerated_Execution_Manager'
HAXM_DIR="/opt/android-sdk/extras/intel/Hardware_Accelerated_Execution_Manager"
sudo ${HAXM_DIR}/silent_install.sh

create_emulator(){
    local avd_name=$1
    local avd_platform=$2
    local avd_img=$3
    local avd_path="/Users/${USER}/.android/avd/${avd_name}"
    echo "avd path: $avd_path"

    rm -f '${AVD_PATH}.ini'
    rm -rf '${AVD_PATH}.avd'

    echo "Creating Android Emulator"
    echo "Name: $avd_name"
    echo "Platform: $avd_platform"
    echo "Image: $avd_img" 
    echo 'no' | android create avd --name "$avd_name" -t "$avd_platform" -b "$avd_img" -f  

    cp "/opt/boxen/repo/android-configs/${avd_name}-config.ini" "${avd_path}.avd/config.ini"
}

create_emulator 'Nexus_5_API_16_Test_Device' 'android-16' 'google_apis/x86'
create_emulator 'Nexus_5_API_21_Test_Device' 'android-21' 'google_apis/x86_64'
create_emulator 'Nexus_5_API_23_Test_Device' 'android-23' 'google_apis/x86_64'
create_emulator 'Nexus_5_API_24_Test_Device' 'android-24' 'google_apis/x86_64'

android list avds
