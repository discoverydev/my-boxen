#!/bin/bash

if ! `which carthage > /dev/null` ; then 
    sudo installer -pkg /opt/boxen/repo/Carthage.pkg -target /
fi
