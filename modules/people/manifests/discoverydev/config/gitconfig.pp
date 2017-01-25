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
    'alias.co'                   : value => 'checkout';
    'alias.br'                   : value => 'branch';
    'alias.hist'                 : value => "log --pretty=format:'%h %ai | %s%d [%an]' --graph --date=short";
    'status.showUntrackedFiles'  : value => 'all';
  }

}
