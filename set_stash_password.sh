#! /bin/bash -eu

echo -n "Enter the http://stash password $(whoami): "
read -s PW
echo ""

: ${PW:?"Need to set password"}
security add-internet-password -a $(whoami) -s stash -r http -U -T /opt/boxen/homebrew/bin/git-credential-osxkeychain -w $PW

echo "Password for $(whoami) set successfully"

