# Internal: Configuration settings for Jenkins
#
# Examples:
#
#   include jenkins::config
class jenkins::config (
  $heap_size = '2G',
  $perm_size = '512M',
  $public = false
) {
  require boxen::config
  require homebrew::config
  require nginx::config

  $configdir     = "${boxen::config::configdir}/jenkins"
  $configfile    = "${configdir}/jenkins.conf"
  $datadir       = "${boxen::config::datadir}/jenkins"
  $pluginsdir    = "${datadir}/plugins"
  $warfile       = "${homebrew::config::installdir}/opt/jenkins/libexec/jenkins.war"
  $logdir        = "${boxen::config::logdir}/jenkins"
  $logfile       = "${logdir}/jenkins.log"
  $consolefile   = "${logdir}/console.log"
  $accesslogfile = "${nginx::config::logdir}/jenkins.access.log"
  $errorlogfile  = "${nginx::config::logdir}/jenkins.error.log"
  $port          = 18080
  $max_heap_size = $heap_size
  $max_perm_size = $perm_size
  $public_port   = $public
}
