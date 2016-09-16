class projects::mlsandroid{

  repository { 'android_platform':
    path => "${boxen::config::srcdir}/mls-dev/android_platform",
    source => "http://${::boxen_user}@stash/scm/mls/android_platform.git",
    ensure => 'development',
    require => Host['stash'],
  }

  repository { 'android_platform_ui':
    path => "${boxen::config::srcdir}/mls-dev/android_platform_ui",
    source => "http://${::boxen_user}@stash/scm/mls/android_platform_ui.git",
    ensure => 'development',
    require => Host['stash'],
  }

  repository { 'android_plugin_account_center':
    path => "${boxen::config::srcdir}/mls-dev/android_plugin_account_center",
    source => "http://${::boxen_user}@stash/scm/mls/android_plugin_account_center.git",
    ensure => 'development',
    require => Host['stash'],
  }

  repository { 'android_plugin_authentication':
    path => "${boxen::config::srcdir}/mls-dev/android_plugin_authentication",
    source => "http://${::boxen_user}@stash/scm/mls/android_plugin_authentication.git",
    ensure => 'development',
    require => Host['stash'],
  }

  repository { 'android_plugin_enac':
    path => "${boxen::config::srcdir}/mls-dev/android_plugin_enac",
    source => "http://${::boxen_user}@stash/scm/mls/android_plugin_enac.git",
    ensure => 'development',
    require => Host['stash'],
  }

  repository { 'android_plugin_network_library':
    path => "${boxen::config::srcdir}/mls-dev/android_plugin_network_library",
    source => "http://${::boxen_user}@stash/scm/mls/android_plugin_network_library.git",
    ensure => 'development',
    require => Host['stash'],
  }

  repository { 'simple_ads_nac_android_shell':
    path => "${boxen::config::srcdir}/mls-dev/simple_ads_nac_android_shell",
    source => "http://${::boxen_user}@stash/scm/mls/simple_ads_nac_android_shell.git",
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
