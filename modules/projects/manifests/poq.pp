class projects::poq {

  boxen::project { 'poq':
    nginx         => 'projects/shared/nginx-poq.conf.erb',
    source        => 'discoverydev/default_boxen_project'
  }
}
