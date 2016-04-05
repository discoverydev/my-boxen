class people::ddaugher {

  notify { 'class people::ddaugher declared': }

  include people::ddaugher::config::osx
  include people::ddaugher::config::gitconfig

  # pull base repository
  boxen::project { 'dotfiles': 
    dir => "/Users/admin/github/dotfiles",
    source => 'ddaugher/scaling-bear'
  }
}
