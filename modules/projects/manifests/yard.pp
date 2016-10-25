class projects::yard {

  boxen::project { 'yard':
    nginx         => 'projects/shared/nginx-yard.conf.erb',
    source        => 'discoverydev/default_boxen_project'
  }
}
