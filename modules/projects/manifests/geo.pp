class projects::geo {

  boxen::project { 'det_john_gimbal':
    source  => 'http://stash/scm/mlsgeo/det_john_gimbal.git',
    require => Host['stash']
  }
  boxen::project { 'geofencer':
    source  => 'http://stash/scm/mlsgeo/geofencer.git',
    require => Host['stash']
  }
  boxen::project { 'gimbal_geofence_importer':
    source  => 'http://stash/scm/mlsgeo/gimbal_geofence_importer.git',
    require => Host['stash']
  }
}