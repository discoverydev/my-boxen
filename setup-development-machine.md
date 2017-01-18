# Setup Development Machine
The standard development machine is managed via a customized Boxen script. The following steps are required for all Discovery Development machines, including 'build' machines.

## Introduction
This is intended to configure Discovery Dev and Build machines on OSX hardware only.

## Getting Started
To give you a brief overview, we're going to:
* Install dependencies (Xcode and command line tools)
* Pull down customized Boxen
* Run Boxen to configure environment
* execute 'after' script to handle non-boxen installs

## Dependencies
### Install the full Xcode
* Go to App Store and install Xcode
* Open Xcode and let it initialize itself
* Accept the license (which requires entering the user's password)
* Install the iOS simulators
* In parallel with the rest of the instructions below, go into Xcode -> Preferences -> Downloads and start downloading the iOS simulators (at least the 8.1 simulator is needed to build the 'ramrod' projects).
* Install/Update the Command Line Tools.
* You may not need to perform this step if the command line tools are already installed. Do it anyway, to ensure that the command line tools are up to date. 

Within a terminal window:
`xcode-select --install`

This will prompt to install Command Line Tools, click the Install button.

At this point verify dependencies are setup properly by running 'git' from Terminal. There should not be any error messages.

## What You Will Get
List of packages installed, intentionally not listed. Please check the [site.pp] file to find the current list of packages installed

## Installation Steps
###Make ga-mlsdiscovery a sudoer
`sudo visudo`
  
find the line in the file: `%admin ALL=(ALL) ALL`
add a new line: `ga-mlsdiscovery ALL=(ALL) NOPASSWD:ALL`

### Create /usr/local on local machine
```
sudo mkdir -p /usr/local
sudo chown ga-mlsdiscovery:staff /usr/local
```

### Configure Boxen on local machine
Running boxen will override the user's ~/.profile from manifests/files/profile
```
sudo mkdir -p /opt/boxen
sudo chown -R ga-mlsdiscovery:staff /opt
git clone https://github.com/discoverydev/my-boxen /opt/boxen/repo
cd /opt/boxen/repo
 
git checkout ads
./set_stash_password
./update_boxen
```

You will be asked for a GitHub login and password. Use the `discoverydev` GitHub user.

```
GitHub login: |ga-mlsdiscovery| discoverydev
GitHub password: **********
```
Once this has completed, restart the terminal in order to source proper variables (runs ~/.profile). Just sourcing ~/.profile isn't enough - Boxen performs environment changes that are outside the scope of the bash profile. Then move on to the next step:
Towards the end of this process, you may see a failure where Boxen tries to pull down the `workstation-files` repo from our local Stash. No big deal - if this happens:
set the stash password again
`./set_stash_password.sh`

execute 'update' Boxen again
`./update_boxen.sh`

If you run into other issues with Git, such as the "Illegal Instruction" error - please see Resolving Git Weirdness

This completes the Boxen process. The steps that follow are additional, manual set up steps.
### 'After' script
The after script will install the 'gold' android-sdk and ios simulators.
```
cd /opt/boxen/repo
./run_after_boxen.sh
```
  
After running this script, you will need to open Xcode, go to Preferences -> Components and click the download arrow next to the 9.2, 9.0, and 8.4 sims. The run_after_boxen script performs the downloading, but this step is still necessary to install the simulators.

### Install the MLS Discovery Development developer profile

If any existing personal accounts have been installed, remove them from Xcode -> Preferences -> Accounts, then remove the certificates and keys from Keychain Access -> My Certificates (see screenshot above).
Download the team.developerprofile file and AppleWWDRCA.cer.
Double-click the file to install the profile.  It will prompt for a password - use the standard ga-mlsdiscovery password.
Double-click the "Alliance Data Systems Corp" team in the new profile and click "Download All"
The first time a build tries to use the new profile, it will prompt to ask for access to the keychain.  Click Always Allow.


## Start/Restart Launchctl
If this is the first time you are executing the following scripts, the 'unload' will result in the following error message - "Could not find specified service".  You can ignore this error message.
```
cd /opt/boxen/repo
./add_plist_entry.sh
```
Please verify the plist was installed and running.  The following should be the last line output by the add_plist_entry.sh script

`-   0   boxen.update`

### Jenkins Setup
There are two steps to integrate the new machine with Jenkins:
Any machine that is Boxenized must have a Boxen monitor job on Jenkins. Just copy one of the previously existing jobs (for instance, Boxen Negasonic), and set the name to Boxen_$HOSTNAME. 
If this machine will be used as a build slave for Jenkins (Mac Minis), you'll also need to add Jenkins slaves. On the Jenkins sidebar, click "Manage Jenkins", then "Manage Nodes" on the page that comes up, and then "New Node" on the sidebar. You can copy the nodes from another machine, but BE CARFEUL and make sure that all the labels are appropriate for the new slave. 
The standard setup is to have 3 build slaves on a node - one for both IOS and Android and another that has the name of the machine (e.g. ROGUE, ROGUE_ANDROID, and ROGUE_IOS). Certain machines will not have all three of these (for example, machines without Genymotion licenses don't need an Android slave.) Even if you don't create all three slaves, as long as you following the naming convention, you can run /opt/boxen/repo/start_jenkins_slave.sh , and it will start the slaves and connect them to Jenkins. Note that this script tries to create all three slaves, so you'll see an error for any slaves that you haven't previously defined in Jenkins, but this can be safely ignored. 
Ensure that iOS 9.2 and iOS 8.1 Simulators are installed.  With Xcode 7.3.1, iOS 9.2 comes with it.  Go to Xcode -> Preferences -> Downloads -> iOS 8.1 Simulator and click the down arrow

### Add SSH Keys to Version Control
Each machine needs an ssh key in the DiscoveryDev github page and in Stash. 
To generate the key and add it to the DiscoveryDev github, see Adding SSH Key for Carthage/ReactiveKit. Please note that when you execute `ssh -T git@github.com` (at the end of the steps in the link), your computer will prompt you for keychain access. Select "Always Allow."
Now that you have an ssh key, go to stash, and log in as ga-mlsdiscovery. In the top right corner, click the account picture (lightbulb), select "Manage Account," then select "SSH Keys" and "Add Key." Paste the contents of ~/.ssh/id_rsa.pub into the box and you're good to go.

### Genymotion License
Registering a computer's Genymotion license is part of the Boxen setup. Clone the Workstation Files repo and open workstation-files/genymotion/register.sh. Copy an entry for your new machine. Since we are out of licenses and will be switching away from Genymotion, copy one of the lines that echos the message about having no license. 

## Boxen Install Complete
### Post Setup Enhancements
Change Hostname
`sudo scutil --set HostName [favorite X-Men character]`

* Add a background image pertaining to the X-Men character you have chosen.
* Add a machine-shared Google account for Hangouts and Chrome Remote Desktop.  This helps prevent needing to log in to google () using other personal or contractor accounts.
* Open Chrome and Click on the person icon in the upper right.
* Create a new gmail account using the name "discoverydev.XMENCHARACTERNAME@gmail.com" (e.g. discoverydev.gambit@gmail.com).  
* Use XMen Name for first name and "Developer" for last name
* Use 1/1/1980 for DOB and "Other" for gender and a shared password (ask one of the tech leads).
* Leave phone blank
* Use adsdiscoveryteam@gmail.com for current email
* Join Google+ so the account can be used as a Hangouts account
* Set the profile picture to match the desktop
* Once Chrome is logged in to this new account (be sure the XMen name is displayed on the upper right of the Chrome window) add Chrome Hangouts and Chrome Remote Desktop extensions.
* Feel free to 'enhance' this new google account (e.g. with an icon like the background image, connect it to other discoverydev.zzz accounts or to remote developer(s) accounts.)
* This account is not to be used for any email communications. It is just a way to sign in to Google products generically
* Add Bookmark Bar bookmarks for adsmail.alldata.net/ confluence/ stash/ jenkins/ and nexus/ to Chrome
* 
* Open "Keychain Access" / Preferences and check "Show keychain status in menu bar" (this will allow you to easily lock the machine from the menu bar)
* 
* Open "Terminal" / Preferences and select Homebrew for "On startup, open:" and in Profiles set it as the default.  Change the Columns and Rows under "Window" to 160x50
* 
* Open System Preferences / General and set "Sidebar icon size:" to "Small" and select "Always" under "Show scroll bars"
* 
* Open "Finder" / Preferences and select "ga-mlsdiscovery" for "New Finder windows show", under "Sidebar" uncheck "iCloud Drive", check "ga-mlsdiscovery", and your computer's name.
* In the "Finder" sidebar move ga-mlsdiscovery to the top and find and drag in "Shared" and "opt" under "Downloads"
* 
* Open System Preferences / Screen Saver and set the Screen Saver to "Message", check "Show with clock", set "Start after:" to "10 Minutes", and click options and set the message to the machine's XMen name

