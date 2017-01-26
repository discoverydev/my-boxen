#!/bin/bash -le

reload() {
  local agent_path=~/Library/LaunchAgents/${1}
  launchctl unload $agent_path
  launchctl load $agent_path
}

place_plist() {
    cp /tmp/workstation-files/LaunchAgents/${1} ~/Library/LaunchAgents/${1}
}

echo "adding boxen.update.plist to launchctl... possibly removed by ADS push to machine."
rm -rf /tmp/workstation-files
git clone http://admin@stash/scm/cypher/workstation-files.git /tmp/workstation-files


place_plist 'boxen.update.plist'
place_plist 'cleanup.mac.plist'
place_plist 'disk.usage.plist'
place_plist 'jenkins2.node.plist'

reload 'boxen.update.plist'
reload 'cleanup.mac.plist'
reload 'disk.usage.plist'
reload 'jenkins2.node.plist'

launchctl list | grep boxen
launchctl list | grep cleanup
launchctl list | grep jenkins2
