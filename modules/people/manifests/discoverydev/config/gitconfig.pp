class people::discoverydev::config::gitconfig {

  # remove the base git config in order to properly install new
  file { "/Users/ga-mlsdiscovery/.gitconfig":
    content => '',
  }
  
  git::config::global {
    'user.name':    value => 'Discovery Dev';
    'user.email':   value => 'adsdiscoveryteam@pillartechnology.com';
    'push.default': value => 'simple';
  }

}
