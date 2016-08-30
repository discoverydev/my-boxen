class projects::tomcat {

  boxen::project { 'tomcat':
    nginx         => 'projects/shared/nginx-tomcat.conf.erb',
    source        => 'discoverydev/default_boxen_project'
  }
}
