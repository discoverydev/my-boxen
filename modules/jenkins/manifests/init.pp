# Public: Installs the Jenkins CI-server
#
# Examples
#
#   include jenkins
class jenkins (
  $max_heap_size = '2G',
  $max_perm_size = '512M',
  $public_port = false
) {
  class { 'jenkins::config':
    heap_size => $max_heap_size,
    perm_size => $max_perm_size,
    public    => $public_port
  }

  include homebrew
  include nginx::config
  include nginx

  file { [
    $jenkins::config::configdir,
    $jenkins::config::logdir,
    $jenkins::config::datadir,
    $jenkins::config::pluginsdir
  ]:
    ensure => directory,
  }

  homebrew::formula { 'jenkins':
    before => Package['boxen/brews/jenkins']
  }

  package { 'boxen/brews/jenkins':
    ensure => '1.580.3-boxen1',
    notify => Service['dev.jenkins']
  }

  file { '/Library/LaunchDaemons/dev.jenkins.plist':
    content => template('jenkins/dev.jenkins.plist.erb'),
    group   => 'wheel',
    notify  => Service['dev.jenkins'],
    owner   => 'root',
  }

  file { "${nginx::config::sitesdir}/jenkins.conf":
    content => template('jenkins/jenkins.conf.erb'),
    require => File[$nginx::config::sitesdir],
    notify  => Service['dev.nginx'],
  }

  service { 'dev.jenkins':
    ensure => running,
  }
}
