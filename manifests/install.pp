class xtrabackup::install {

  if $xtrabackup::install_xtrabackup_bin == true {
    yumrepo { 'percona':
      descr    => 'CentOS $releasever - Percona',
      baseurl  => 'http://repo.percona.com/centos/$releasever/os/$basearch/',
      gpgkey   => 'http://www.percona.com/downloads/percona-release/RPM-GPG-KEY-percona',
      enabled  => 1,
      gpgcheck => 1,
    }

    package { "percona-xtrabackup-${xtrabackup::package_version}":
      ensure  => present,
      require => Yumrepo['percona'],
    }

    file { "${xtrabackup::backup_script_location}/xtrabackup.sh":
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => '0755',
      content => template('xtrabackup/xtrabackup.sh.erb'),
    }
  }
}
