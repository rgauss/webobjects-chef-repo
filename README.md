Overview
========

This chef repository provides a cookbook and roles to deploy WebObjects applications
on LINUX distros.

After adding the `webobjects` cookbook to your chef repo you can add roles to install and configure an
Apache http server and the WebObjects application server.


Chef Setup
==========

Typically you'd fork or clone this repository then create a `.chef` directory with your credentials and
`knife.rb` file to connect to your chef server.

If unfamiliar with chef check out the [quick start page](http://wiki.opscode.com/display/chef/Quick+Start) and
instead of cloning their repository clone this one

	git clone git://github.com/rgauss/webobjects-chef-repo.git

You can then set attributes on your chef nodes or roles that override the defaults.


Roles
=====

* `webobjects_application_server` - Installs a WebObjects 5.4 application server (`wotaskd` and `JavaMonitor`).
* `webobjects_http_server` - Installs an Apache 2 web server and builds a WebObjects adaptor.


EC2 Deployment
==============

If you're deploying on EC2 check out the [EC2 Knife plugin](http://help.opscode.com/kb/knife/knife-plugins-ec2) which
(after setting your AWS key and secret) can make deploying a standalone WebObjects server as easy as:

	knife ec2 server create --region us-east-1 -Z us-east-1a -I ami-cf33fea6 -f t1.micro -G <YOUR_GROUPS> -i ~/.ec2/<YOUR_EC2_KEY_PAIR>.pem -S <YOUR_EC2_KEY_PAIR> --ssh-user ubuntu -r role[webobjects_http_server],role[webobjects_application_server]

Notes
=====

* At the time of this writing there seems to be an issue getting chef-client running on CentOS images unrelated to
this cookbook.


This cookbook adapted from the [ObjectStyle Wiki](http://wiki.objectstyle.org/confluence/display/WO/Platforms)