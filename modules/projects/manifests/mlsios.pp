class projects::mlsios {

  repository { 'ios_platform':
    path => "${boxen::config::srcdir}/mls-dev/ios_platform",
    source => "http://${::boxen_user}@stash/scm/mls/ios_platform.git",
    ensure => 'development',
    require => Host['stash'],
  }

  repository { 'ios_platform_ui':
    path => "${boxen::config::srcdir}/mls-dev/ios_platform_ui",
    source => "http://${::boxen_user}@stash/scm/mls/ios_platform_ui.git",
    ensure => 'development',
    require => Host['stash'],
  }

  repository { 'ios_plugin_account_center':
    path => "${boxen::config::srcdir}/mls-dev/ios_plugin_account_center",
    source => "http://${::boxen_user}@stash/scm/mls/ios_plugin_account_center.git",
    ensure => 'development',
    require => Host['stash'],
  }

  repository { 'ios_plugin_authentication':
    path => "${boxen::config::srcdir}/mls-dev/ios_plugin_authentication",
    source => "http://${::boxen_user}@stash/scm/mls/ios_plugin_authentication.git",
    ensure => 'development',
    require => Host['stash'],
  }

  repository { 'ios_plugin_enac':
    path => "${boxen::config::srcdir}/mls-dev/ios_plugin_enac",
    source => "http://${::boxen_user}@stash/scm/mls/ios_plugin_enac.git",
    ensure => 'development',
    require => Host['stash'],
  }

  repository { 'ios_plugin_network_library':
    path => "${boxen::config::srcdir}/mls-dev/ios_plugin_network_library",
    source => "http://${::boxen_user}@stash/scm/mls/ios_plugin_network_library.git",
    ensure => 'development',
    require => Host['stash'],
  }

  repository { 'simple_ads_nac_ios_shell':
    path => "${boxen::config::srcdir}/mls-dev/simple_ads_nac_ios_shell",
    source => "http://${::boxen_user}@stash/scm/mls/simple_ads_nac_ios_shell.git",
    ensure => 'development',
    require => Host['stash'],
  }

  repository { 'nac_appium_test_suite':
    path => "${boxen::config::srcdir}/mls-dev/nac_appium_test_suite",
    source => "http://${::boxen_user}@stash/scm/mls/nac_appium_test_suite.git",
    ensure => 'development',
    require => Host['stash'],
  }

}
