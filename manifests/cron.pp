class xtrabackup::cron {

  if $xtrabackup::enable_cron == true {
    cron { 'xtrabackup':
      ensure   => present,
      user     => root,
      command  => 'xtrabackup_command.sh',
      hour     => $xtrabackup::cron_hour,
      minute   => $xtrabackup::cron_minute,
      month    => $xtrabackup::cron_month,
      monthday => $xtrabackup::cron_monthday,
    }
  }
  if $xtrabackup::enable_cron == false {
    cron { 'xtrabackup':
      ensure   => absent,
      user     => root,
      command  => 'xtrabackup_command.sh',
      hour     => $xtrabackup::cron_hour,
      minute   => $xtrabackup::cron_minute,
      month    => $xtrabackup::cron_month,
      monthday => $xtrabackup::cron_monthday,
    }
  }
}
