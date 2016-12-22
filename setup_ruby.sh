#!/bin/bash -l

echo "Installing Ruby 2.0.0"
#Only installing if it is not already installed
echo 'no' | rbenv install 2.0.0-p648
rbenv local 2.0.0-p648
echo "Removing gems which require native extensions."
echo "These can be reinstalled with current extensions from a bundle file in your project."
gem uninstall rmagick -a -I -x
gem uninstall nokogiri -a -I -x
