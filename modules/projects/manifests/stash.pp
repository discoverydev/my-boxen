 class projects::stash {  

    boxen::project { 'stash':
    nginx         => 'projects/shared/nginx-stash.conf.erb',
    source        => 'discoverydev/default_boxen_project'
  }
}