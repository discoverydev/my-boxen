#!/bin/bash

NUMBER=$1
HOST=$2

dscl . create /Users/minion${NUMBER} 
dscl . create /Users/minion${NUMBER} UserShell /bin/bash
dscl . create /Users/minion${NUMBER} RealName "${HOST} Minion ${NUMBER}"
dscl . create /Users/minion${NUMBER} UniqueID "100${NUMBER}"
dscl . create /Users/minion${NUMBER} PrimaryGroupID 20
dscl . create /Users/minion${NUMBER} NFSHomeDirectory /Users/minion${NUMBER}
dscl . passwd /Users/minion${NUMBER} M0bileL0yalty







