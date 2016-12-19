#!/bin/bash -le

reload() {
  local agent_path=~/Library/LaunchAgents/${1}
  launchctl unload $agent_path
  launchctl load $agent_path
}

echo "adding boxen.update.plist to launchctl... possibly removed by ADS push to machine."
rm -rf /tmp/workstation-files
git clone http://admin@stash/scm/cypher/workstation-files.git /tmp/workstation-files

cp /tmp/workstation-files/LaunchAgents/boxen.update.plist ~/Library/LaunchAgents/boxen.update.plist
cp /tmp/workstation-files/LaunchAgents/cleanup.mac.plist ~/Library/LaunchAgents/cleanup.mac.plist


reload 'boxen.update.plist'
reload 'cleanup.mac.plist'

launchctl list | grep boxen
launchctl list | grep cleanup
