#!/bin/bash -l

echo "updating brew"
brew -v update
echo "upgrading  brew"
brew -v upgrade 
echo "cleaning up old versions"
brew -v cleanup
