class projects::confluence {

  boxen::project { 'confluence':
    nginx         => 'projects/shared/nginx-confluence.conf.erb',
    source        => 'discoverydev/default_boxen_project'
  }
}
