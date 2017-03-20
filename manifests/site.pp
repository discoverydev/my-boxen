require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::homebrewdir}/bin",
    '/usr/bin',
    '/usr/local/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew'],
  install_options => ['--appdir=/Applications', '--force']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>


node default {
  # core modules, needed for most things
  include dnsmasq
  include git
  include hub
  include nginx
  include brewcask

  include sublime_text
  # sublime_text::package { 'Emmet': source => 'sergeche/emmet-sublime' }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }


  #
  # NODE stuff
  #

  class { 'nodejs::global': version => '7.7.1' }

  $version = '7.7.1'
  npm_module { "npm":
    module       => 'npm',
    node_version => $version
  }

  npm_module { 'appium':
    module       => 'appium',
    version      => '1.6.3',
    node_version => $version
  }

  npm_module { 'ios-sim':
    module       => 'ios-sim',
    node_version => $version
  }

  npm_module { 'phantomjs':
    module       => 'phantomjs-prebuilt',
    node_version => $version
  }

  npm_module { 'deviceconsole':
    module => 'deviceconsole',
    node_version => $version
  }

  #
  # RUBY stuff
  #

  ruby::version { '2.2.2': }
  ruby::version { '2.0.0-p648': }
  class { 'ruby::global': version => '2.2.2' }

  ruby_gem { 'bundler':
    gem          => 'bundler',
    ruby_version => '*',
  }
  ruby_gem { 'cocoapods':
    gem          => 'cocoapods',
    ruby_version => '2.2.2',
  }
  ruby_gem { 'ocunit2junit': # not sure if this is necessary here
    gem          => 'ocunit2junit',
    ruby_version => '*',
  }
  ruby_gem { 'appium_console':
    gem          => 'appium_console',
    ruby_version => '2.2.2',
  }
  ruby_gem { 'rspec':
    gem          => 'rspec',
    ruby_version => '*',
  }
  ruby_gem { 'xcpretty':
    gem          => 'xcpretty',
    ruby_version => '2.0.0-p648',
  }
  ruby_gem { 'xcpretty for 2.2':
    gem          => 'xcpretty',
    ruby_version => '2.2.2',
  }
  ruby_gem { 'fastlane':
    gem          => 'fastlane',
    ruby_version => '2.2.2',
  }
  ruby_gem { 'pry-coolline':
    gem          => 'pry-coolline',
    ruby_version => '*',
  }

  #
  # PYTHON stuff
  #

  # geofencing uses python scripts
  exec { 'pip':  # python package manager
    command => 'sudo easy_install pip',
    creates => '/usr/local/bin/pip',
  }
  exec { 'virtualenv':  # python environment manager
    require => Exec['pip'],
    command => 'sudo pip install virtualenv',
    creates => '/usr/local/bin/virtualenv',
  }
  exec { 'create_virtual_environment':
    require => Exec['virtualenv'],
    command => 'virtualenv python_env',
  }
  exec { 'install_python_mock': # python testing tool
    require => Exec['create_virtual_environment'],
    command => "${boxen::config::repodir}/python_env/bin/pip install --upgrade mock",
  }
  exec { 'install_python_nose': # python testing tool
    require => Exec['create_virtual_environment'],
    command => "${boxen::config::repodir}/python_env/bin/pip install --upgrade nose",
  }

  #
  # BREW and BREW CASKS
  #

  exec { "tap-discoverydev-ipa":
    command => "brew tap discoverydev/ipa",
    creates => "${homebrew::config::tapsdir}/discoverydev/homebrew-ipa",
  }

  package {
    [
      'ack',               # for searching strings within files at the command-line
      'ant',               # for builds
      'bash-completion',   # enables more advanced bash completion features. used by docker bash completion.
      'bash-git-prompt',   # Display git branch, change info in the bash prompt
      'chromedriver',      # for appium
  #    'docker',            # to run prebuilt containers, used by ci (stash, jenkins, etc)
      'docker-machine',    # to run docker from os-x
      'dos2unix',          # some Java cmd-line utilities are Windows-specific
      'fabric',            # python based tool for interacting with multiple machines
      'git',               #
      'gradle',            # for builds
      'grails',            # application framework (for simple checkout sample)
      'groovy',            # groovy language (for simple checkout)
      'ideviceinstaller',  # for appium on ios devices
      'imagemagick@6',     # for (aot) imprinting icons with version numbers
      'jq',                # basically awk for json
      'maven',             # for builds
      'mockserver',        # for mocking servers for testing
      'openssl',           # for ssl
      'p7zip',             # 7z, XZ, BZIP2, GZIP, TAR, ZIP and WIM
      'pv',                # pipeview for progress bar
      'rbenv',             # ruby environment manager
      'sbt',               # scala build tool (for Gimbal Geofence Importer)
      'scala',             # scala language (for Gimbal Geofence Importer)
      #'sonar-runner',     # code quality metrics
      'ssh-copy-id',       # simplifies installation of ssh keys on remote servers
      'swiftlint',         # linter for swift files
      'tmux',              # terminal multiplexer with session management (it's rad)
      'tomcat',            # for deploying .war files (simple-checkout)
      'tree',              # displays directory tree in command line
      'wget',              # get things from the web (alternative to curl)
      'xctool',            # xcode build, used by sonar
      #'discoverydev/ipa/carthage',          # xcode dependency management

      'https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb' # sshpass - used for piping passwords into ssh commands. it is MUCH better to set up a keypair. ask coleman if you don't know how. this is used to push to rackspace windows for red lion.
     ]:
     ensure => present,
     require => Exec['tap-discoverydev-ipa'],
  }

  # common, useful packages -- brew-cask
  package { [
      'android-studio',    # IDE for android coding
      'appium1413',        # for testing mobile emulators, simulators, and devices
      'atom',              # edit text
      'caffeine',          # keep the machine from sleeping
      'citrix-receiver',   # Citrix VPN
      'docker',            # it's docker
      'firefox',           # browser
      #'genymotion',        # android in virtualbox (faster). commented for now because we now use the default android emulator which ships with the sdk.
      'google-chrome',     # browser
      'google-hangouts',   # communication tool
      'grandperspective',  # disk inspection util
      #'intellij1416',      # IDE all the things
      'iterm2',            # terminal replacement
      #'java',              # java 8. commented out for now as ADS remotely updates the jdk in line with corp policy
      'qlgradle',          # quicklook for gradle files
      'qlmarkdown',        # quicklook for md files
      'qlprettypatch',     # quicklook for patch files
      'qlstephen',         # quicklook for text files
      'slack',             # communication tool
      'sourcetree',        # Atlassian Sourcetree
      'virtualbox',        # VM for docker-machine, genymotion, etc
    ]:
    provider => 'brewcask',
    ensure => present,
    require => Exec['tap-discoverydev-ipa'],
  }

  #
  # MANUAL STUFF
  #

  # for iOS simulator to work
  exec { 'sudo /usr/sbin/DevToolsSecurity --enable':
    unless => "/usr/sbin/DevToolsSecurity | grep 'already enabled'"
  }

  exec { 'install_imagemagick_fonts': # Tell ImageMagick where to find fonts on this system
    require => Package['imagemagick@6'],
    command => "${boxen::config::repodir}/manifests/scripts/install_imagemagick_fonts.sh"
  }

  exec { 'install-carthage': # Install carthage
    command => "${boxen::config::repodir}/manifests/scripts/install-carthage.sh"
  }

  exec { 'install-vim-pathogen': # Install vim pathogen
    command => "${boxen::config::repodir}/manifests/scripts/install-vim-pathogen.sh"
  }

  exec { 'link-imagemagick': # make sure imagemagick@6 is linked
    command => "${boxen::config::repodir}/manifests/scripts/relink-imagemagick.sh"
  }

  exec { 'no-bash-profile': # remove ~/.bash_profile if it's there - we use ~/.profile
    command => "rm -f /Users/ga-mlsdiscovery/.bash_profile"
  }

  # install HP printer drivers
  package { 'HP Printer Drivers':
    ensure => installed,
    source => 'http://support.apple.com/downloads/DL907/en_US/hpprinterdriver3.1.dmg',
    provider => pkgdmg,
  }

  #
  # HOSTNAME to IPs
  #

  # aliases by service name
  host { 'jenkins2'     : ip => '192.168.8.44'  }
  host { 'stash'        : ip => '192.168.8.37'  }
  host { 'nexus'        : ip => '192.168.8.37'  }
  host { 'tomcat'       : ip => '192.168.8.32'  }
  host { 'confluence'   : ip => '205.144.60.35' }
  host { 'sonarqube'    : ip => '192.168.8.35'  }
  host { 'mockserver'   : ip => '192.168.8.35'  }
  host { 'yard'         : ip => '192.168.8.35'  }

  # aliases by machine name - CI
  host { 'xavier'       : ip => '192.168.8.31' } # Pillar
  host { 'warlock'      : ip => '192.168.8.33' } # Pillar
  host { 'wolverine'    : ip => '192.168.8.34' } # Pillar
  host { 'beast'        : ip => '192.168.8.35' } # CAD5IRITSPDISC07
  host { 'mystique'     : ip => '192.168.8.36' } # CAD4IRITSPDISC18
  host { 'negasonic'    : ip => '192.168.8.37' } # CAD4IRITSPDISC19
  host { 'apocalypse'   : ip => '192.168.8.38' } # CAD4IRITSPDISC20

  # aliases by machine name - workstations
  # please note that laptops are not aliased here - see the equipment list for details on those
  host { 'juggernaut'   : ip => '192.168.8.140'  } # CAD5IRITSPDISC01
  host { 'gambit'       : ip => '192.168.8.3'  } # CAD5IRITSPDISC02
  host { 'magneto'      : ip => '192.168.8.4'  } # CAD5IRITSPDISC03
  host { 'banshee'      : ip => '192.168.8.29' } # CAD5IRITSPDISC04
  host { 'colossus'     : ip => '192.168.8.6'  } # CAD5IRITSPDISC05
  host { 'longshot'     : ip => '192.168.8.28' } # CAD5IRITSPDISC08
  host { 'nightcrawler' : ip => '192.168.8.10' } # CAD5IRITSPDISC09
  host { 'bishop'       : ip => '192.168.8.11' } # CAD5IRITSPDISC10
  host { 'iceman'       : ip => '192.168.8.12' } # CAD5IRITSPDISC11
  host { 'havok'        : ip => '192.168.8.30' } # CAD5IRITSPDISC12
  host { 'sabretooth'   : ip => '192.168.8.14' } # CAD5IRITSPDISC13
  host { 'deadpool'     : ip => '192.168.8.18' } # CAD5IRITSPDISC17
  host { 'phoenix'      : ip => '192.168.8.22' } # CAD5IRITSPDISC21
  host { 'shadowcat'    : ip => '192.168.8.23' } # CAD5IRITSPDISC22
  host { 'storm'        : ip => '192.168.8.24' } # CAD5IRITSPDISC23
  host { 'cable'        : ip => '192.168.8.25' } # CAD5IRITSPDISC24
  host { 'angel'        : ip => '192.168.8.26' } # CAD5IRITSPDISC25
  host { 'doop'         : ip => '192.168.8.40' } # CAD4IRITSPDISC26
  host { 'dazzler'      : ip => '192.168.8.5'  } # CAD4IRITSPDISC27
  host { 'anole'        : ip => '192.168.8.9'  } # CAD4IRITSBDISC28
  host { 'stryker'      : ip => '192.168.8.42' } # CAD4IRITSBDISC29
  host { 'bastion'      : ip => '192.168.8.44' } # CAD4IRITSBDISC31
  host { 'rogue'        : ip => '192.168.8.45' } # CAD4IRITSBDISC30

  host { 'retail-jira'          : ip => '205.144.60.35' }
  host { 'retail-stash'         : ip => '205.144.60.35' }
  host { 'retail-nexus'         : ip => '205.144.60.35' }
  host { 'retail-confluence'    : ip => '205.144.60.35' }
  host { 'retail-jenkins'       : ip => '205.144.60.35' }

  # yellow lion laptops

  host { 'warpath'        : ip => '192.168.8.52' } #
  host { 'VOLTRON1'        : ip => '192.168.8.46' } #CAD4MRITSPDISC32
  host { 'VOLTRON2'        : ip => '192.168.8.54' } #CAD4MRITSPDISC33
  host { 'VOLTRON3'        : ip => '192.168.8.57' } #CAD4MRITSPDISC37
  host { 'VOLTRON4'        : ip => '192.168.8.48' } #CAD4MRITSBDISC45
  host { 'VOLTRON5'        : ip => '192.168.8.59' } #CAD4MRITSPDISC39
  host { 'VOLTRON6'        : ip => '192.168.8.58' } #CAD4MRITSPDISC38
  host { 'photon7'        : ip => '192.168.8.61' } #CAD4MRITSPDISC41
  host { 'VOLTRON8'        : ip => '192.168.8.67' } #CAD4MRITSPDISC48
  host { 'VOLTRON9'        : ip => '192.168.8.71' } #CAD4MRITSPDISC52
  host { 'VOLTRON10'       : ip => '192.168.8.74' } #CAD4MRITSPDISC55
  host { 'VOLTRON11'       : ip => '192.168.8.49' } #CAD4MRITSPDISC59
  host { 'VOLTRON12'       : ip => '192.168.8.55' } #CAD4MRITSPDISC35
  host { 'VOLTRON13'       : ip => '192.168.8.62' } #CAD4MRITSPDISC42
  host { 'VOLTRON14'       : ip => '192.168.8.56' } #CAD4MRITSPDISC36
  host { 'VOLTRON15'       : ip => '192.168.8.63' } #CAD4MRITSPDISC43
  host { 'VOLTRON16'       : ip => '192.168.8.64' } #CAD4MRITSPDISC43
  host { 'photon17'       : ip => '192.168.8.6' } #CAD4MRITSPDISC40
  host { 'VOLTRON18'       : ip => '192.168.8.65' } #CAD4MRITSPDISC46
  host { 'VOLTRON19'       : ip => '192.168.8.60' } #CAD4MRITSPDISC40
  host { 'VOLTRON20'       : ip => '192.168.8.69' } #CAD4MRITSPDISC50
  host { 'VOLTRON21'       : ip => '192.168.8.70' } #CAD4MRITSPDISC51
  host { 'VOLTRON22'       : ip => '192.168.8.72' } #CAD4MRITSPDISC53
  host { 'VOLTRON23'       : ip => '192.168.8.73' } #CAD4MRITSPDISC54
  host { 'VOLTRON24'       : ip => '192.168.8.75' } #CAD4MRITSPDISC56

 #
  # CLEAN UP
  #
  # packages that should not be present anymore
  package { 'android-sdk': ensure => absent }   # instead, custom pre-populated android-sdk installed after boxen

}
