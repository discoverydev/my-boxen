class projects::mockserver {

  boxen::project { 'mockserver':
    nginx         => 'projects/shared/nginx-mockserver.conf.erb',
    source        => 'discoverydev/default_boxen_project'
  }

  $mockserver_path = "/Users/Shared/data/mockserver/api-blueprint-mockserver"
  $specs_path = "/Users/Shared/data/mockserver/api-blueprint-specs"

  repository { 'api-blueprint-mockserver':
    path => $mockserver_path,
    source => "https://bitbucket.org/outofcoffee/api-blueprint-mockserver.git",
    ensure => master,
  }

  repository { 'api-blueprint-specs':
    path => $specs_path,
    source => "http://${::boxen_user}@stash/scm/cypher/api-blueprint-specs.git",
    ensure => master,
  }

}