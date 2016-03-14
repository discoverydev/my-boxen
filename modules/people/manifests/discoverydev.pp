class people::discoverydev {

  #notify { 'class people::discoverydev declared': }

  include people::discoverydev::config::osx
  include people::discoverydev::config::gitconfig

  file { "/Users/${::boxen_user}/.profile":
    source => "${boxen::config::repodir}/manifests/files/profile"
  }
  
  file { "/Users/${::boxen_user}/.vimrc":
    source => "${boxen::config::repodir}/manifests/files/vimrc"
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

  file { "/Users/${::boxen_user}/.ssh/config":
    source => "${boxen::config::repodir}/manifests/files/ssh-config"
  }

  file { "sonar-runner.properties":
    name => "${homebrew::config::installdir}/Cellar/sonar-runner/2.5/libexec/conf/sonar-runner.properties",
    source => "${boxen::config::repodir}/manifests/files/sonar-runner.properties",
    require => Package['sonar-runner'],
  }

}
