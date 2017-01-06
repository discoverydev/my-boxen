class people::discoverydev::config::gitconfig ( $email = downcase($hostname) ) {

 # remove the base git config in order to properly install new
  file { "/Users/ga-mlsdiscovery/.gitconfig":
    content => '',
  }

  git::config::global {
    'user.name'                  : value => 'Discovery Dev';
    'user.email'                 : value => "discoverydev.${email}@gmail.com"; 
    'push.default'               : value => 'simple';
    'alias.nuke'                 : value => 'reset --hard HEAD';
    'status.showUntrackedFiles'  : value => 'all';
  }

}
