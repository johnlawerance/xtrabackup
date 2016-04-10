class xtrabackup::cron {

  if $xtrabackup::enable_cron == true {
    cron { 'xtrabackup':
      ensure   => present,
      user     => root,
      command  => "${xtrabackup::backup_script_location}/xtrabackup.sh",
      hour     => $xtrabackup::cron_hour,
      minute   => $xtrabackup::cron_minute,
      weekday  => $xtrabackup::cron_weekday,
      month    => $xtrabackup::cron_month,
      monthday => $xtrabackup::cron_monthday,
    }
  }
  if $xtrabackup::enable_cron == false {
    cron { 'xtrabackup':
      ensure   => absent,
      user     => root,
      command  => "${xtrabackup::backup_script_location}/xtrabackup.sh",
      hour     => $xtrabackup::cron_hour,
      minute   => $xtrabackup::cron_minute,
      weekday  => $xtrabackup::cron_weekday,
      month    => $xtrabackup::cron_month,
      monthday => $xtrabackup::cron_monthday,
    }
  }
}
