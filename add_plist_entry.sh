#!/bin/bash -le 

echo "adding boxen.update.plist to launchctl... possibly removed by ADS push to machine."
launchctl unload ~/Library/LaunchAgents/boxen.update.plist
launchctl load ~/Library/LaunchAgents/boxen.update.plist
