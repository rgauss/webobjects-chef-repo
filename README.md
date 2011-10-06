Overview
========

This chef repository provides a cookbook and roles to deploy WebObjects applications
on LINUX distros.

After adding the `webobjects` cookbook to your chef repo you can add roles to install and configure an
Apache http server and the WebObjects application server.


Roles
=====

* `webobjects_application_server` - Installs a WebObjects application server (`wotaskd` and `JavaMonitor`).
* `webobjects_http_server` - Installs an Apache web server and builds a WebObjects adaptor.
