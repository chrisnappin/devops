class apache {

  # install the apache2 package
  package {"apache2":
    ensure => present
  }
  
  # set the docroot to a symlink back to the src directory 
  file { '/var/www/src':
    ensure => 'link',
    target => '/vagrant/src',
    require => Package['apache2']
  }
  
  # install the 000-default.conf file
  file { '/etc/apache2/sites-available/000-default.conf':
    source => 'puppet:///modules/apache/000-default.conf',
    owner => 'root',
	group => 'root',
    require => Package['apache2']
  }
  
  # start the service
  service { "apache2":
    require => Package["apache2"],
    subscribe => [File['/etc/apache2/sites-available/000-default.conf']]
  }
  
}  