class examples::hashtag {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  include epel
  yumrepo { 'base':
    ensure     => 'present',
    descr      => 'CentOS-$releasever - Base',
    enabled    => '1',
    gpgcheck   => '0',
    mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os&infra=$infra',
  }

  yumgroup { 'Development Tools':
    ensure  => present,
    require => Yumrepo['base', 'epel'],
  }
  
  package { 'ruby-devel':
    ensure => present,
  }

  package { 'twitter':
    ensure   => present,
    provider => gem,
    require  => [ Yumgroup['Development Tools'], Package['ruby-devel'] ],
  }

  file { '/usr/local/bin/hashtag':
    ensure => file,
    mode   => '0755',
    source => 'puppet:///modules/examples/hashtag',
  }

}
