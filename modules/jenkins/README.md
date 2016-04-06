# Jenkins Puppet Module for Boxen

[![Build Status](https://travis-ci.org/boxen/puppet-jenkins.png?branch=master)](https://travis-ci.org/boxen/puppet-jenkins)

This installs the [Jenkins CI-server](http://jenkins-ci.org) on your machine.

## Usage

```puppet
include jenkins
```

Browse to [http://jenkins.dev](http://jenkins.dev).

### Options

You can pass optional class arguments to control heap and permgen sizes
in Jenkins Java VM via [java command line arguments](https://wiki.jenkins-ci.org/display/JENKINS/Starting+and+Accessing+Jenkins):

```puppet
class { 'jenkins':
  max_heap_size => '6G',
  max_perm_size => '512M'
}

```

### Plugins

Installing:

```puppet
jenkins::plugin { 'notification':
   version => '1.4'
}
```

Removing:

```puppet
jenkins::plugin { 'notification':
   ensure => absent
}
```

## Required Puppet Modules

* `boxen`
* `homebrew`
* `nginx`
* `repository`

## Environment

Once installed, you can access the following variables in your environment, projects, etc:

* BOXEN_JENKINS_PORT: The port on which Jenkins listens
* BOXEN_JENKINS_HOME: The Jenkins home-directory
