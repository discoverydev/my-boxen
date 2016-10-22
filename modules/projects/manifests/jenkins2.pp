class projects::jenkins2 {

  boxen::project { 'jenkins2':
    nginx         => 'projects/shared/nginx-jenkins2.conf.erb',
    source        => 'discoverydev/default_boxen_project'
  }
}
