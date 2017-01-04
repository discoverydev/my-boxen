#!/bin/bash 

HOST=$(hostname -s)

PERCENTAGE=$(df -H | awk -v HOST=${HOST} '/\/dev\/disk.*/ { print substr($5, 0, length($5)-1) }')

echo "Disk usage: ${PERCENTAGE}%"
echo "Sending disk usage check results for ${HOST} to Jenkins."

curl -X POST http://jenkins2/job/DiskUsage_${HOST}/buildWithParameters?PERCENTAGE=${PERCENTAGE}
