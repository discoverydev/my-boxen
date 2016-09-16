#!/bin/sh

# Make sure only root can execute this script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be executed using sudo" 1>&2
   exit 1
fi

echo "* quitting any running instances of VirtualBox"
osascript -e 'quit app "VirtualBox"'

echo "* shutting down local jenkins instance"
curl --silent --request POST "http://localhost:8080/exit"

read -p "do you want to delete the 'src' directory?: (Y/n)" DELETE_SRC
DELETE_SRC=${DELETE_SRC:-y}

if [ "$DELETE_SRC" = y ]
then
  echo "** deleting directory : ~/src"
  rm -rf ~/src
else
  echo "* keeping 'src' directory."
fi

echo "** deleting virtual box images"
rm -rf ~/VirtualBox\ VMs/
echo "** deleting boot2docker directory"
rm -rf ~/.boot2docker/
echo "** deleting jenkins directories"
rm -rf ~/.jenkins/
rm -rf ~/jenkins_slave/
echo "** deleting .subversion directory"
rm -rf ~/.subversion/
echo "** deleting rubies directory"
rm -rf ~/rubies
echo "** deleting .m2"
rm -rf ~/.m2/
echo "** deleting .ivy2 directory"
rm -rf ~/.ivy2/
echo "** deleting Nexus directory"
rm -rf ~/Nexus_5_API_21_x86/
echo "** deleting local Applications"
rm -rf ~/Applications/

echo "** deleting homebrew-cask directory"
rm -rf /opt/homebrew-cask
echo "** deleting rubies directory"
rm -rf /opt/rubies
echo "** deleting nodes directory"
rm -rf /opt/nodes
echo "** deleting android-sdk"
rm -rf /opt/android-sdk
echo "** deleting android-sdk"
rm -rf /opt/android-sdk
echo "** deleting mockability-server"
rm -rf /opt/mockability-server
echo "** deleting dynatrace"
rm -rf /opt/dynatrace

echo "** deleting various dot files"
rm -rf ~/.gemrc ~/.CFUserTextEncoding ~/.profile ~/.gitignore ~/.gitconfig ~/.viminfo ~/.lesshst ~/.common_shell_profile ~/.zshrc ~/.vimrc ~/.docker-completion.bash ~/.git-completion.bash 

echo "** nuking boxen install"
cd ~
/opt/boxen/repo/script/nuke --force --all
rm -rf /opt/boxen
