class web_example {
  
  # install IIS
  windowsfeature { 'IIS':
    feature_name => [
      'Web-Server',
      'Web-WebServer'
    ]
  }
  
  # start IIS
  service { 'W3SVC':
      ensure => 'running',
      enable => true,
  }
  
  file { 'c:/inetpub/wwwroot/Default.htm':
      ensure => 'file',
      owner  => 'Administrator',
      group  => 'Administrators',
      source => 'puppet:///modules/web_example/Default.htm',
  }
  
}  