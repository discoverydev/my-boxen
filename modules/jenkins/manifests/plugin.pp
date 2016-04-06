# Public: Install a Jenkins plugin
#
# Examples
#
#   jenkins::plugin { 'notification':
#      version => '1.4'
#   }
define jenkins::plugin (
  $ensure = present,
  $plugin = $title,
  $version = undef
) {
  include jenkins::config

  $downloads  = 'http://updates.jenkins-ci.org/download/plugins/'
  $pluginsdir = $jenkins::config::pluginsdir
  $pluginfile = "${pluginsdir}/${plugin}.jpi"
  $clijar = "${jenkins::config::datadir}/war/WEB-INF/jenkins-cli.jar"

  case $ensure {
    present: {
      if ($version == undef) {
        fail('cannot ensure present without version attribute')
      }

      $version_regex = regsubst($version, '\.', '\\.')
      exec { "${plugin} v${version}":
        command => "curl -fsSL -o ${pluginfile} ${downloads}${plugin}/${version}/${plugin}.hpi",
        unless  => "java -jar ${clijar} -s http://jenkins.dev/ list-plugins ${plugin} |grep -qE '${version_regex}( \\(.*\\))?$'",
        require => File[$pluginsdir],
        notify  => Service['dev.jenkins']
      }
    } # end present

    default: {
      file { [ "${jenkins::config::pluginsdir}/${plugin}.jpi", "${jenkins::config::pluginsdir}/${plugin}" ]:
        ensure => absent,
        backup => false,
        force  => true,
        notify => Service['dev.jenkins']
      }
    } # end default
  }
}
