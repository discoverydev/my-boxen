# Boxen Repo

This repository contains our Boxen configuration. This readme explains a few key points about how we use Boxen, and where you should look if you're trying to make changes. If you have questions that aren't covered here, ask Coleman. 

## Boxen Updates
Boxen runs nightly on each of the machines in the room. This automation is done via launchctl and requires that a plist file is put in place on each machine. This should only need to happen once. The plist file lives in the workstation-files repo (which is hosted on our Discovery network Stash instance). There is a script in the root of this repository called `add_plist_entry.sh` which you can run to setup this plist file. 

Boxen updates and installs various software packages through various mechanisms (e.g. rubygems, pip, brew, etc). It also copies various files into place and manages OSX settings. A listing of files that are important to this process follows: 

## Important Files
`repo/manifests/site.pp` - this file is the main manifest file. This file manages a few different things. There are some general setup items toward the top of the file, including setup of the `PATH` variable (though this seems to be flaky, and we manage the PATH in the shell profile too). It also manages any packages installed by various managers (pip, brew, etc). It runs a few bash scripts that set up various things (see the section under `"MANUAL STUFF"`). Lastly, it manages the hostname => ip address mappings that wind up in /etc/hosts. 

To summarize, if you're making changes to the packages installed by pip, npm, rubygems, or homebrew, they go here. If you're making changes to /etc/hosts, or running custom scripts as part of the automated config, those changes go here too.

`repo/manifests/files/` - any files that are to be copied into the filesystem at large go here. Examples include the bash profile and the vimrc. Boxen can change the filenames when these are copied into their final locations, so these files need not be named the same in the repo as they will be on the filesystem. This is mainly useful for dotfiles, which, if named with the preceding dot, would be hidden and not show up with `ls`. 

`repo/modules/people/manifests/discoverydev.pp` - this file is the manifest for the discoverydev user (ga-mlsdiscovery). It is used primarily for copying files into place - see the file for example syntax. This file has the capability to copy whole directories as well as individual files - there are examples of both cases in the file. 

## Shell Profiles
Currently, we have shell profiles in place for both zsh and bash. The majority of the functionality in these profiles is shared between bash and zsh. There are three files relevant to this process (these live in /opt/boxen/repo/manifests/files): `common_shell_profile`, `zshrc`, and `profile`. `profile` and `zshrc` source `common_shell_profile` for the majority of their functionality. Anything that can be used by both shells (aliases, functions, PATH manipulation, etc) should go into `common_shell_profile`. Changes which are specific to either zsh or bash should be placed `zshrc` or `profile` respectively. 
