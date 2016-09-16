class projects::sonarqube {

  boxen::project { 'sonarqube':
    nginx         => 'projects/shared/nginx-sonarqube.conf.erb',
    source        => 'discoverydev/default_boxen_project'
  }
}
