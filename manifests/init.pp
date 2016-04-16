# Class: xtrabackup
# ===========================
#
# This module installs Percona xtrabackup / innobackupx and schedules automated
# backups of MySQL, MariaDB, Percona-Server and other MySQL derivitives.
#
# Parameters
# ----------
#
# Required Module Parameters
# --------
# 
# `backup_dir`
# Location to store the backup files (default: '') [REQUIRED]
#
# `mysql_user`
# User that should perform the backup (default: '') [REQUIRED]
#
# `mysql_pass`
# Password that should perform the backup (default: '') [REQUIRED]
#
#
# Complete Module Parameters
# --------
#
# `package_version`
# Which version of xtrabackup binaries to install (default: latest)
#
# `install_xtrabackup_bin`
# Should the module install the Percona repo and manage the xtrabackup
# packages? (default: true)
#
# `prune_backups`
# Should the module manage backup retention? (default: true)
#
# `backup_retention`
# Time in days the module should keep old backups around (default: 7)
#
# `backup_dir`
# Location to store the backup files (default: '') [REQUIRED]
#
# `use_innobackupx`
# Should the module use the `innobackupx` command instead of `xtrabackup`?
# (default: false)
#
# `backup_script_location`
# Where should the backup shell script be installed?
# (default: '/usr/local/bin/')
#
# `mysql_user`
# User that should perform the backup (default: '') [REQUIRED]
#
# `mysql_pass`
# Password that should perform the backup (default: '') [REQUIRED]
#
# `enable_cron`
# Should the module manage the cronjob to perform the backups? (default: true)
#
# `cron_hour`
# Hour(s) to schedule the backup (default: '1') # Cronjob defaults
# for daily at 1AM
#
# `cron_minute`
# Minute(s) to schedule the backup (default: '0')
#
# `cron_weekday`
# Weekday(s) to schedule the backup (default: '*')
#
# `cron_month`
# Month(s) to schedule the backup (default: '*')
#
# `cron_monthday`
# Monthday(s) to schedule the backup (default: '*')
#
# `xtrabackup_options`
# Extra options to pass to the xtrabackup command (default: '')
#
# `innobackupx_options`
# Extra options to pass to the innobackupx command (default: '')
#
# `logfile`
# Location where the shell script output should be logged
# (default: '/var/log/xtrabackup.log')
#
#
#
# Examples
# --------
#
# Minimal installation using default settings:
# 
# class { ::xtrabackup:
#   backup_dir => '/mnt/backup/',
#   mysql_user => 'backup_user',
#   mysql_pass => 'backup_password'
# }
#

# Install xtrabackup version 2.3.4-1.el7 and the backup script but don't
# schedule cronjob.
#
# class { ::xtrabackup:
#   package_version => '2.3.4-1.el7',
#   enable_cron     => false,
#   backup_dir      => '/mnt/backup/',
#   mysql_user      => 'backup_user',
#   mysql_pass      => 'backup_password'
# }
#
# Schedule backup for weekly Friday night's at 11PM, set the backup retention
# to 30 days, and don't install the xtrabackup packages:
#
# class { ::xtrabackup:
#   backup_retention       => '30',
#   cron_hour              => '22',
#   cron_weekday           => '5',
#   install_xtrabackup_bin => false,
#   backup_dir             => '/mnt/backup/',
#   mysql_user             => 'backup_user',
#   mysql_pass             => 'backup_password'
# }
#
# Schedule backup with custom xtrabackup options to use 2 threads and
# compress the output:
#
# class { ::xtrabackup:
#   xtrabackup_options => '--parallel=2 --compress',
#   backup_dir         => '/mnt/backup/',
#   mysql_user         => 'backup_user',
#   mysql_pass         => 'backup_password'
# }
#
# Schedule backup using innobackupx with custom options to save slave data:
#
# class { ::xtrabackup:
#   use_innobackupx     => true,
#   innobackupx_options => '--slave-info',
#   backup_dir          => '/mnt/backup/',
#   mysql_user          => 'backup_user',
#   mysql_pass          => 'backup_password'
# }
#
#
# Authors
# -------
#
# John Clark <john@johnlawerance.com>
#
# Copyright
# ---------
#
# Copyright 2016 John Clark, WTFPL
#
class xtrabackup (
  $package_version = 'latest',
  $install_xtrabackup_bin = true,
  $prune_backups = true,
  $backup_retention = '7',
  $backup_dir = '', # Required
  $use_innobackupx = false,
  $backup_script_location = '/usr/local/bin/',
  $mysql_user = '', # Required
  $mysql_pass = '', # Required
  $enable_cron = true,
  $cron_hour = '1', # Cronjob defaults for daily at 1AM
  $cron_minute = '0',
  $cron_weekday = '*',
  $cron_month = '*',
  $cron_monthday = '*',
  $xtrabackup_options = '',
  $innobackupx_options = '',
  $logfile = '/var/log/xtrabackup.log',
  
  
){
  # Validate arguments
  validate_string($package_version)
  validate_bool($use_innobackupx)
  validate_bool($install_xtrabackup_bin)
  validate_bool($prune_backups)
  validate_integer($backup_retention)
  validate_absolute_path($backup_dir)
  validate_absolute_path($backup_script_location)
  validate_string($mysql_user)
  validate_string($mysql_pass)
  validate_bool($enable_cron)
  
  class {'::xtrabackup::repo': } ->
  class {'::xtrabackup::install': } ->
  class {'::xtrabackup::cron': }

}
