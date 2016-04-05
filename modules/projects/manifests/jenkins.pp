class projects::jenkins {

  boxen::project { 'jenkins':
    nginx         => 'projects/shared/nginx-jenkins.conf.erb',
    source        => 'discoverydev/default_boxen_project'
  }
}
