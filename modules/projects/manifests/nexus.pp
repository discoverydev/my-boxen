class projects::nexus {  

  boxen::project { 'nexus':
    nginx         => 'projects/shared/nginx-nexus.conf.erb',
    source        => 'discoverydev/default_boxen_project'
  }
}