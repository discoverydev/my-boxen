class projects::ramrod {
	
  # ramrod android projects
  boxen::project { 'ramrod_android_core':     
    source => 'http://stash/scm/spikes/ramrod_android_core.git',
    require => Host['stash'] 
  }
  boxen::project { 'ramrod_android_foo':      
    source => 'http://stash/scm/spikes/ramrod_android_foo.git', 
    require => Host['stash'] 
  }
  boxen::project { 'ramrod_android_bar':      
    source => 'http://stash/scm/spikes/ramrod_android_bar.git', 
    require => Host['stash'] 
  }
  boxen::project { 'ramrod_android_shell':    
    source => 'http://stash/scm/spikes/ramrod_android_shell.git', 
    require => Host['stash'] 
  }

  # ramrod ios projects
  boxen::project { 'ramrod_ios_core':         
    source => 'http://stash/scm/spikes/ramrod_ios_core.git', 
    require => Host['stash'] 
  }
  boxen::project { 'ramrod_ios_foo':          
    source => 'http://stash/scm/spikes/ramrod_ios_foo.git', 
    require => Host['stash'] 
  }
  boxen::project { 'ramrod_ios_bar':          
    source => 'http://stash/scm/spikes/ramrod_ios_bar.git', 
    require => Host['stash'] 
  }
  boxen::project { 'ramrod_ios_shell':        
    source => 'http://stash/scm/spikes/ramrod_ios_shell.git', 
    require => Host['stash'] 
  }

  # ramrod functional tests
  boxen::project { 'ramrod-functional-tests': 
    source => 'http://stash/scm/spikes/ramrod-functional-tests.git', 
    require => Host['stash'] 
  }

#  exec { 'ramrod_android_core-build':
#    cwd         => "/Users/${::boxen_user}/src/ramrod_android_core",
#    command     => '/bin/sh ci/all.sh',
#    environment => ["ANDROID_HOME=/opt/android-sdk"],
#    require     => Boxen::Project['ramrod_android_core']
#  }
#  exec { 'ramrod_android_foo-build':
#    cwd         => "/Users/${::boxen_user}/src/ramrod_android_foo",
#    command     => '/bin/sh ci/all.sh',
#    environment => ["ANDROID_HOME=/opt/android-sdk"],
#    require     => [Exec['ramrod_android_core-build'], Boxen::Project['ramrod_android_foo']]
#  }
#  exec { 'ramrod_android_bar-build':
#    cwd         => "/Users/${::boxen_user}/src/ramrod_android_bar",
#    command     => '/bin/sh ci/all.sh',
#    environment => ["ANDROID_HOME=/opt/android-sdk"],
#    require     => [Exec['ramrod_android_core-build'], Boxen::Project['ramrod_android_bar']]
#  }
#  exec { 'ramrod_android_shell-build':
#    cwd         => "/Users/${::boxen_user}/src/ramrod_android_shell",
#    command     => '/bin/sh ci/all.sh',
#    environment => ["ANDROID_HOME=/opt/android-sdk"],
#    require     => [Exec['ramrod_android_foo-build'], Exec['ramrod_android_bar-build'], Boxen::Project['ramrod_android_shell']]
#  }
#
#  exec { 'ramrod_ios_core-build':
#    cwd     => "/Users/${::boxen_user}/src/ramrod_ios_core",
#    command => '/bin/sh ci/all.sh',
#    require => Boxen::Project['ramrod_ios_core']
#  }
#  exec { 'ramrod_ios_foo-build':
#    cwd     => "/Users/${::boxen_user}/src/ramrod_ios_foo",
#    command => '/bin/sh ci/all.sh',
#    require => [Exec['ramrod_ios_core-build'], Boxen::Project['ramrod_ios_foo']]
#  }
#  exec { 'ramrod_ios_bar-build':
#    cwd     => "/Users/${::boxen_user}/src/ramrod_ios_bar",
#    command => '/bin/sh ci/all.sh',
#    require => [Exec['ramrod_ios_core-build'], Boxen::Project['ramrod_ios_bar']]
#  }
#  exec { 'ramrod_ios_shell-build':
#    cwd     => "/Users/${::boxen_user}/src/ramrod_ios_shell",
#    command => '/bin/sh ci/all.sh',
#    require => [Exec['ramrod_ios_foo-build'], Exec['ramrod_ios_bar-build'], Boxen::Project['ramrod_ios_shell']]
#  }
}