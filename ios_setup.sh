#!/bin/bash

USER=ga-mlsdiscovery
SERVER=192.168.8.36 # mystique

source ~/.profile

echo "* adding ${SERVER} to known_hosts"
ssh-keyscan ${SERVER} > ~/.ssh/known_hosts

TARFILE=ios_sims.tar.gz
DESTINATION=/opt
SRC=/Users/${USER}/ios_sims

echo "* copy ${TARFILE} from ${SERVER} (${SRC}) to ${DESTINATION}"

pushd ${DESTINATION}
echo "  user ${USER}"
rsync -ru --progress ${USER}@${SERVER}:${SRC}/${TARFILE} ${DESTINATION}/${TARFILE}
tar xzkvf ${TARFILE}
popd

mkdir -p ~/Library/Caches/com.apple.dt.Xcode/Downloads

mv ${DESTINATION}/com.apple.pkg.iPhoneSimulatorSDK8_4-8.4.1.1435785476.dmg ~/Library/Caches/com.apple.dt.Xcode/Downloads
mv ${DESTINATION}/com.apple.pkg.iPhoneSimulatorSDK9_0-9.0.1.1443554484.dmg ~/Library/Caches/com.apple.dt.Xcode/Downloads
mv ${DESTINATION}/com.apple.pkg.iPhoneSimulatorSDK9_2-9.2.1.1451951473.dmg ~/Library/Caches/com.apple.dt.Xcode/Downloads
