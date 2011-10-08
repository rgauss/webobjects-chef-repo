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

If unfamiliar with chef check out the [quick start page](http://wiki.opscode.com/display/chef/Quick+Start) and

You'll need to setup a `.chef` directory with your credentials and `knife.rb` file to connect to your chef server.

You can then create a data bag with settings unique to your app and set attributes on your chef nodes or roles
that override the defaults.


Roles
=====

* `webobjects_application_server` - A WebObjects 5.4 application server (`wotaskd` and `JavaMonitor`).
* `webobjects_http_server` - An Apache 2 web server and builds a WebObjects adaptor.
* `webobjects_compile_server` - A server setup to compile WebObjects applications from source.  Note that you must provide
the Apple, Wonder, woproject.jar, and other third-party frameworks.


Data Bags
=========

See [this post](http://www.opscode.com/blog/2010/05/06/data-driven-application-deployment-with-chef/)
on the use of Opscode's application deployment cookbooks and the use of data bags.

While this cookbook doesn't directly use any of the deployment recipes in that cookbook it follows
the same precedence there.

Some additional data bag attributes used by this cookbook are `deploy_name` which when used like:

	"deploy_name": "MyApp"

Designates that you're deploying a WebObjects app of `MyApp.woa` and the `application_properties` attribute:

  "application_properties": {
  	"production": {
  		"application_url": "https://www.example.com/cgi-bin/WebObjects/MyApp.woa",
  		"smtp_host": "smtp.example.com",
  	},
  	"staging": {
  		"application_url": "https://staging.example.com/cgi-bin/WebObjects/MyApp.woa",
  		"smtp_host": "localhost",
  	}
  }

where you might use these to manipulate a system properties file from a chef template before deploying.


EC2 Deployment
==============

If you're deploying on EC2 check out the [EC2 Knife plugin](http://help.opscode.com/kb/knife/knife-plugins-ec2) which
(after setting your AWS key and secret) can make deploying a standalone WebObjects server as easy as:

	knife ec2 server create --region us-east-1 -Z us-east-1a -I ami-cf33fea6 -f t1.micro -G <YOUR_GROUPS> -i ~/.ec2/<YOUR_EC2_KEY_PAIR>.pem -S <YOUR_EC2_KEY_PAIR> --ssh-user ubuntu -r role[webobjects_http_server],role[webobjects_application_server]


Recipes
=======

* `build_apache_adaptor` - Downloads the wonder adaptor source, builds, and installs the `mod_WebObjects` module.
* `compile` - Assumes you already have a `ant` build script and simply runs the default target.
* `deploy_locally` - copies the built deployments to the local applications and resources directories, useful for standalone
deployments.
* `deploy_to_java_monitor` - Tells the `JavaMonitor` about the apps location and adds and instance of it.
* `git_source` - Clones the application source from git, configured via data bags.
* `modify_apache_config` - Creates an Apache config file from a template.
* `modify_system_file_limits` - Changes the number of open files allowed.
* `setup_compile_environment` - Creates a few directories and config files needed fro building WebObjects apps from source
* `setup_deployment_environment` - Downloads and installs `wotaskd` and `JavaMonitor`, installs and starts a webobjects service,
and sets JavaMonitor up with a host, site config, and password.



Notes
=====

* At the time of this writing there seems to be an issue getting chef-client running on CentOS images unrelated to
this cookbook.


This cookbook adapted from the [ObjectStyle Wiki](http://wiki.objectstyle.org/confluence/display/WO/Platforms)