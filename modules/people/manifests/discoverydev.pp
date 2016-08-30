################################################################################
#
#     repo/modules/manifests/discoverydev.pp
#     This is the manifest file for the discoverydev user. It is used 
#     for copying various files into the places where they belong and 
#     pretty much nothing else. The two include lines at the top of the class
#     bring in configuration for OSX settings and git. 
#
################################################################################

class people::discoverydev {

  include people::discoverydev::config::osx
  include people::discoverydev::config::gitconfig

  ### Common Shell Profile

  file { "/Users/${::boxen_user}/.common_shell_profile":
    source => "${boxen::config::repodir}/manifests/files/common_shell_profile"
  }

  ### Bash Config

  file { "/Users/${::boxen_user}/.profile":
    source => "${boxen::config::repodir}/manifests/files/profile"
  }

  file { "/Users/${::boxen_user}/.git-completion.bash":
    source => "${boxen::config::repodir}/manifests/files/git-completion.bash"
  }

  file { "/Users/${::boxen_user}/.docker-completion.bash":
    source => "${boxen::config::repodir}/manifests/files/docker-completion.bash"
  }

  file { "/Users/${::boxen_user}/.docker-machine-completion.bash":
    source => "${boxen::config::repodir}/manifests/files/docker-machine-completion.bash"
  }


  ### ZSH Config 

  file { "/Users/${::boxen_user}/.zshrc":
    source => "${boxen::config::repodir}/manifests/files/zshrc"
  }

  file { "ZSH Prompt Config":
    ensure => 'directory',
    path => "/Users/ga-mlsdiscovery/.zsh",
    source => "${boxen::config::repodir}/manifests/files/zsh",
    recurse => true 
  }


  ### Vim Config

  file { "/Users/${::boxen_user}/.vimrc":
    source => "${boxen::config::repodir}/manifests/files/vimrc"
  }


  ### SSH Config

  file { "/Users/${::boxen_user}/.ssh":
    ensure => 'directory'
  }

  file { "/Users/${::boxen_user}/.ssh/config":
    source => "${boxen::config::repodir}/manifests/files/ssh-config"
  }

  file { "/Users/${::boxen_user}/.ssh/rc":
    source => "${boxen::config::repodir}/manifests/files/ssh-rc"
  }


  ### Copy Xcode Templates
  
  file { "Xcode Template":
    ensure => 'directory',
    path => "/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates/Source/QuickSpec File.xctemplate/",
    source => "${boxen::config::repodir}/manifests/files/xcode-templates/QuickSpec/",
    recurse => true 
  }


  ### Misc

  file { "/etc/pf.conf":
    source => "${boxen::config::repodir}/manifests/files/pf.conf"
  }

  exec { 'firewall config':
    require => File['/etc/pf.conf'],
    command => 'sudo pfctl -f /etc/pf.conf'
  }

  #file { "sonar-runner.properties":
  #  name => "${homebrew::config::installdir}/Cellar/sonar-runner/2.5/libexec/conf/sonar-runner.properties",
  #  source => "${boxen::config::repodir}/manifests/files/sonar-runner.properties",
  #  require => Package['sonar-runner'],
  #}

}
