#!/bin/bash -eu

# This script copies the ios simulator dmg files into the download location for Xcode. 
# After running this, the user needs to open Xcode, navigate to the simulator download page, and 
# 'download' the sims. They will install quickly since the actual download piece has been 
# performed by this script.h

echo "################################################################################"
echo "#                               ios_setup.sh                                   #"
echo "################################################################################"

if [[ $(instruments -s devices | grep '8.4') && $(instruments -s devices | grep '9.0') && $(instruments -s devices | grep '9.2') ]]; then
    echo "ios_setup.sh : Looks like we've already got the simulators. Exiting without changes."
    exit 0
fi 

USER=ga-mlsdiscovery
SERVER=192.168.8.36 # mystique

source ~/.profile

echo "ios_setup.sh : adding ${SERVER} to known_hosts"
ssh-keyscan ${SERVER} > ~/.ssh/known_hosts

TARFILE=ios_sims.tar.gz
DESTINATION=/opt
SRC=/Users/${USER}/ios_sims

echo "ios_setup.sh : copy ${TARFILE} from ${SERVER} (${SRC}) to ${DESTINATION}"

pushd ${DESTINATION}
echo "  user ${USER}"
rsync -ru --progress ${USER}@${SERVER}:${SRC}/${TARFILE} ${DESTINATION}/${TARFILE}
tar xzkvf ${TARFILE}
popd

mkdir -p ~/Library/Caches/com.apple.dt.Xcode/Downloads

echo "ios_setup.sh : moving sim dmg files into proper location"

mv ${DESTINATION}/com.apple.pkg.iPhoneSimulatorSDK8_4-8.4.1.1435785476.dmg ~/Library/Caches/com.apple.dt.Xcode/Downloads
mv ${DESTINATION}/com.apple.pkg.iPhoneSimulatorSDK9_0-9.0.1.1443554484.dmg ~/Library/Caches/com.apple.dt.Xcode/Downloads
mv ${DESTINATION}/com.apple.pkg.iPhoneSimulatorSDK9_2-9.2.1.1451951473.dmg ~/Library/Caches/com.apple.dt.Xcode/Downloads

echo "ios_setup.sh : copy complete. please open xcode and install the simulators"
