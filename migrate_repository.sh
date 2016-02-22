#!/bin/bash -le

echo "force pulling history from new repository"

cd /opt/boxen/repo
git fetch origin
git reset --hard origin/ads
./update_boxen.sh
