# This file is meant to be copied into a minion's user directory as .profile
# There's no automation around this as of 05-09-16 but once in place on Negasonic and Apocalypse it shouldn't have to be copied again

# This line sets the PATH variable to the same as ga-mlsdiscovery
PATH=$PATH:$(sudo -Hiu ga-mlsdiscovery env | grep ^PATH | cut -d '=' -f 2)


# We also source ga-mlsdiscovery's profile
source /Users/ga-mlsdiscovery/.profile

