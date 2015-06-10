class apache {

  package {"apache2":
    ensure => present
  }
  
  file { '/var/www/src':
    ensure => 'link',
    target => '/vagrant/src',
    require => Package['apache2']
  }
  
  file { '/etc/apache2/sites-available/000-default.conf':
    source => 'puppet:///modules/apache/000-default.conf',
    owner => 'root',
	group => 'root',
    require => Package['apache2']
  }
  
  service { "apache2":
    require => Package["apache2"],
    subscribe => [File['/etc/apache2/sites-available/000-default.conf']]
  }
  
  
}  