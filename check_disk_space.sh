#!/bin/bash 

PERCENTAGE=$(df -H | awk -v HOST=$(hostname) '/\/dev\/disk.*/ { print substr($5, 0, length($5)-1) }')

curl -X POST http://jenkins2/job/DiskUsage_$(hostname -s)/buildWithParameters?PERCENTAGE=${PERCENTAGE}
