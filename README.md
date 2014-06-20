openldap_client
===============

Puppet Module for managing OpenLDAP clients

 SETUP
-------

-Create a 'files' directory in the 'openldap_client' directory.

-Copy your 'ca certificate' in the 'files' directory so your puppetmaster can push your ca certificate out to all of your puppet agents.

-Edit the openldap_client/manifests/paramas.pp file with your settings.

-Make sure the ca certificate in the 'openldap_client/files' directory has at least read for group and other (chmod 644) so you do not get a Permission Denied error on your puppet agent -t run.
