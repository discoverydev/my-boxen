class projects::workstation {

  $user_home = "/Users/${::boxen_user}"
  $workstation_files = "${boxen::config::srcdir}/workstation-files"

  repository { 'workstation-files':
    path => $workstation_files,
    source => "http://${::boxen_user}@stash/scm/cypher/workstation-files.git",
    ensure => master,
  }

  exec { 'update-workstation-files': 
    require => Repository['workstation-files'],
    cwd => $workstation_files,
    command => 'git pull',
  }


  #
  # genymotion licenses
  #

  exec { 'genymotion-license-registration': 
    require => Exec['update-workstation-files'],
    command => "bash -c ./register.sh",
    cwd => "${workstation_files}/genymotion"
  }



  #
  # maven global settings
  #

  file { 'm2':
    name => "${user_home}/.m2",
    ensure => directory,
  }

  file { 'settings.xml':
    require => [File['m2'],Exec['update-workstation-files']],
    name => "${user_home}/.m2/settings.xml",
    source => "${workstation_files}/m2/settings.xml",
  }

  #
  # gradle global settings
  #

  file { 'gradle':
    name => "${user_home}/.gradle",
    ensure => directory,
  }

  file { 'init.gradle':
    require => [File['gradle'],Exec['update-workstation-files']],
    name => "${user_home}/.gradle/init.gradle",
    source => "${workstation_files}/gradle/init.gradle",
  }

  file { 'gradle.properties':
    require => [File['gradle'],Exec['update-workstation-files']],
    name => "${user_home}/.gradle/gradle.properties",
    source => "${workstation_files}/gradle/gradle.properties",
  }

  #
  # boxen auto-updater
  #

  file { "LaunchAgents":
    name => "${user_home}/Library/LaunchAgents",
    ensure => directory,
  }

  file { "boxen.update.plist":
    require => [File['LaunchAgents'],Exec['update-workstation-files']],
    name => "${user_home}/Library/LaunchAgents/boxen.update.plist",
    source => "${workstation_files}/LaunchAgents/boxen.update.plist"
  }

  exec { "unload-boxen-update-to-plist":
    require => File['boxen.update.plist'],
    command => "launchctl unload boxen.update.plist",
    path    => "/usr/local/bin/:/bin/:/usr/bin/",
    user    => root,
  }

  exec { "load-boxen-update-to-plist":
    require => Exec['unload-boxen-update-to-plist'],
    command => "launchctl load boxen.update.plist",
    path    => "/usr/local/bin/:/bin/:/usr/bin/",
    user    => root,
  }

  #
  # keychain certificates
  #

  exec { "adscorporate-root-ca":
    require => Exec['update-workstation-files'],
    command => "security add-trusted-cert -d -r trustRoot -k '/Library/Keychains/System.keychain' '${workstation_files}/certs/ADSCorporate-Root-CA.cer'",
    path    => "/usr/local/bin/:/bin/:/usr/bin/",
    user    => root,
  }

  exec { "adsretail-issuing-ca":
    require => Exec['update-workstation-files'],
    command => "security add-trusted-cert -d -r trustRoot -k '/Library/Keychains/System.keychain' '${workstation_files}/certs/ADSRetail-Issuing-CA.cer'",
    path    => "/usr/local/bin/:/bin/:/usr/bin/",
    user    => root,
  }

  exec { "iphone-distribution":
    require => Exec['update-workstation-files'],
    command => "security import Certificates_sept24.p12 -k ~/Library/Keychains/login.keychain -P $(cat Certificates_sept24.password)",
    cwd => "${workstation_files}/certs"
  }

  #
  # xcode provisioning
  #

  exec { "mobileprovisions":
    require => [Exec['update-workstation-files'],Exec['iphone-distribution']],
    cwd => $workstation_files,
    command => "bash -c 'for f in mobileprovisions/*; do open $f; done'; osascript -e 'tell app \"Xcode\" to quit'",
  }


  $local_pipeline_setup = "${boxen::config::srcdir}/local_pipeline_setup"

  repository { 'local_pipeline_setup':
    path => $local_pipeline_setup,
    source => "http://${::boxen_user}@stash/scm/mls/local_pipeline_setup.git",
    ensure => master,
  }

}
