# == Class
#
# openldap_client
#
# == Synopsis
#
# This is the main OpenLDAP class for managing OpenLDAP client connection
# across a domain with Puppet.
#
# == Author
#
# John McCarthy <midactsmystery@gmail.com>
#
# - http://www.midactstech.blogspot.com -
# - https://www.github.com/Midacts -
#
# == Date
#
# 19th of June, 2014
#
# -- Version 1.0 --
#
class openldap_client {

  require openldap_client::params

  package { 'ldap-utils':
    ensure      => latest,
  }

  package { 'libnss-ldapd':
    ensure      => latest,
    require     => Package['ldap-utils'],
  }

  package { 'nslcd':
    ensure      => latest,
    require     => Package['libnss-ldapd'],
  }

  file { '/etc/pam.d/common-session':
    ensure      => present,
    content     => template('openldap_client/common-session.erb'),
    mode        => 640,
    owner       => root,
    group       => root,
    require     => Package['nslcd'],
  }

  file { '/etc/ldap/ldap.conf':
    ensure      => present,
    content     => template('openldap_client/ldap.conf.erb'),
    mode        => 640,
    owner       => root,
    group       => root,
    require     => File['/etc/pam.d/common-session'],
  }

  file { '/etc/nslcd.conf':
    ensure      => present,
    content     => template('openldap_client/nslcd.conf.erb'),
    mode        => 640,
    owner       => root,
    group       => nslcd,
    require     => File['/etc/ldap/ldap.conf'],
  }

  file { '/etc/nsswitch.conf':
    ensure      => present,
    content     => template('openldap_client/nsswitch.conf.erb'),
    mode        => 640,
    owner       => root,
    group       => root,
    require     => File['/etc/nslcd.conf'],
  }

  file { "${openldap_client::params::tls_cacertfile}":
    ensure      => present,
    source	=> "puppet:///modules/openldap_client/${openldap_client::params::cacert}",
    backup	=> false,
    mode        => 640,
    owner       => root,
    group       => nslcd,
    require     => File['/etc/nsswitch.conf'],
  }

  service { 'nslcd':
    ensure	=> true,
    enable	=> true,
    subscribe	=> [ File['/etc/nslcd.conf'], File['/etc/nsswitch.conf'], File['/etc/ldap/ldap.conf'] ],
  }

}
