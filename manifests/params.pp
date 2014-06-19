# == Class
#
# openldap_client::params
#
# == Synopsis
#
# This is the main OpenLDAP class for managing variables for the OpenLDAP 
# Puppet class.
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
class openldap_client::params {

  $suffix_name		= 'example'
  $suffix_root		= 'com'

  $tls_cacertfile	= '/etc/ssl/certs/ca.crt'
  $cacert		= 'ca.crt'

  $openldap_address	= '192.168.1.63'
  $bindpw		= 'supersecretsquirrel'

}
