Overview
========

This chef repository provides a cookbook and roles to deploy [WebObjects](http://en.wikipedia.org/wiki/WebObjects) applications
on LINUX distros.

After adding the `webobjects` cookbook to your chef repo you can add roles to install and configure an
Apache http server and the WebObjects application server.


Chef Setup
==========

Typically you'd fork or clone this repository:

	git clone git://github.com/rgauss/webobjects-chef-repo.git

upload to your chef server, then create nodes with the appropriate roles for deployment.

If unfamiliar with chef check out the [quick start page](http://wiki.opscode.com/display/chef/Quick+Start).

You'll need to setup a `.chef` directory with your credentials and `knife.rb` file to connect to your chef server.

You can then create a data bag with settings unique to your app and set attributes on your chef nodes or roles
that override the defaults.


Usage
=====

See the `webobjects` cookbook for details on usage.


Roles
-----

* `webobjects_application_server` - A WebObjects 5.4 application server (`wotaskd` and `JavaMonitor`).
* `webobjects_http_server` - An Apache 2 web server and builds a WebObjects adaptor.
* `webobjects_compile_server` - A server setup to compile WebObjects applications from source.  Note that you must provide
the Apple, Wonder, woproject.jar, and other third-party frameworks.


EC2 Deployment
==============

If you're deploying on EC2 check out the [EC2 Knife plugin](http://help.opscode.com/kb/knife/knife-plugins-ec2) which
(after setting your AWS key and secret) can make deploying a standalone WebObjects server as easy as:

	knife ec2 server create --region us-east-1 -Z us-east-1a -I ami-cf33fea6 -f t1.micro -G <YOUR_GROUPS> -i ~/.ec2/<YOUR_EC2_KEY_PAIR>.pem -S <YOUR_EC2_KEY_PAIR> --ssh-user ubuntu -r role[webobjects_http_server],role[webobjects_application_server]

