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

  file { "/Users/${::boxen_user}/.ssh":
    ensure => 'directory'
  }

  file { "/Users/${::boxen_user}/.ssh/config":
    source => "${boxen::config::repodir}/manifests/files/ssh-config"
  }

  file { "/Users/${::boxen_user}/.ssh/rc":
    source => "${boxen::config::repodir}/manifests/files/ssh-rc"
  }

  file { "/etc/pf.conf":
    source => "${boxen::config::repodir}/manifests/files/pf.conf"
  }

  file { "sonar-runner.properties":
    name => "${homebrew::config::installdir}/Cellar/sonar-runner/2.5/libexec/conf/sonar-runner.properties",
    source => "${boxen::config::repodir}/manifests/files/sonar-runner.properties",
    require => Package['sonar-runner'],
  }

  ### Copy Xcode Templates
  file { "/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates/Source/QuickSpec File.xctemplate/":
    ensure => 'directory'
  }

  file { "/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates/Source/QuickSpec File.xctemplate/___FILEBASENAME___.swift":
    source => "${boxen::config::repodir}/manifests/files/xcode-templates/QuickSpec/___FILEBASENAME___.swift"
  }

  file { "/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates/Source/QuickSpec File.xctemplate/TemplateIcon.png":
    source => "${boxen::config::repodir}/manifests/files/xcode-templates/QuickSpec/TemplateIcon.png"
  }

  file { "/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates/Source/QuickSpec File.xctemplate/TemplateIcon@2x.png":
    source => "${boxen::config::repodir}/manifests/files/xcode-templates/QuickSpec/TemplateIcon@2x.png"
  }

  file { "/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates/Source/QuickSpec File.xctemplate/TemplateInfo.plist":
    source => "${boxen::config::repodir}/manifests/files/xcode-templates/QuickSpec/TemplateInfo.plist"
  }

}
