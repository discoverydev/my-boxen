#!/bin/bash -l
echo "updating boxen"
cd /opt/boxen/repo
git checkout ads
git pull

echo "kill xcode"
killall Simulator || true
killall Xcode || true

echo "calling brew_update_pre_boxen script in order to update brew dependencies."
./brew_update_pre_boxen.sh

echo "running boxen script"
./script/boxen --debug workstation

# This will obtain the return status of the last command (boxen)
RESULT=$?
echo "boxen completed with the following exit code : " $RESULT

############################
# boxen uses Puppet's feature of '--detailed-exitcodes' and extends the standard '0' exit code on success
#   - an exit code of '0' means success and no changes
#   - an exit code of '2' means there were changes, 
#   - an exit code of '4' means there were failures during the transaction, and 
#   - an exit code of '6' means there were both changes and failures.
############################
if [ $RESULT -eq 0 ] || [ $RESULT -eq 2 ]
then
    echo "Boxen was updated successfully."
    echo "Sending results to Jenkins."
    curl http://jenkins/job/Boxen_$(hostname -s)/buildWithParameters?CALLER=BOXEN
    . /opt/boxen/env.sh
else 
    echo "Boxen was NOT updated successfully."
    exit 1
fi

./add_plist_entry.sh
