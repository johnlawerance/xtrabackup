# Class: xtrabackup
# ===========================
#
# Full description of class xtrabackup here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'xtrabackup':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class xtrabackup (
  $package_version = '24-2.4.1-1',
  $install_xtrabackup_bin = true,
  $backup_retention = '7',
  $backup_dir = '',
  $backup_script_location = '/usr/local/bin/',
  $mysql_user = '',
  $mysql_pass = '',
  $enable_cron = true,
  $cron_hour = '1', # Cronjob defaults for daily at 1AM
  $cron_minute = '0',
  $cron_month = '*',
  $cron_monthday = '*',
  $innobackupx_options = '',
  
  
){
  # Validate arguments
  validate_re($package_version, '^*\.*\.*')
  validate_bool($install_xtrabackup_bin)
  validate_integer($backup_retention)
  validate_absolute_path($backup_dir)
  validate_absolute_path($backup_script_location)
  validate_string($mysql_user)
  validate_string($mysql_pass)
  validate_bool($enable_cron)
  
  class {'::xtrabackup::install': } ->
  class {'::xtrabackup::cron': }

}
