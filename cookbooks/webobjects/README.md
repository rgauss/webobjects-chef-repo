Description
===========

Installs and configures a WebObjects service (wotaskd and JavaMonitor) and Apache adaptor.

---
Requirements
============

Platform
--------

Only tested on Ubuntu.

Cookbooks
---------

* apache2
* build-essential
* java

---
Attributes
==========

* `node["java"]["install_flavor"]` - Flavor of JVM you would like installed (`sun` or `openjdk`), default `openjdk`.

* `node[:app_environment]` - The chef environment. Default: "_default"

* `node[:webobjects][:wonder_source_remote_url]` - Where to downlowd the wonder source. Default: "http://webobjects.s3.amazonaws.com/Wonder-Source.tar.gz"
* `node[:webobjects][:wonder_source_local_package]` - What to call wonder source once downloaded. Default: "Wonder-Source.tar.gz"
* `node[:webobjects][:wonder_source_dir_Utilities]` - Where to find the wonder utilities dir. Default: "Utilities"
* `node[:webobjects][:wonder_source_dir_Adaptors]` - Where to find the wonder adaptors dir. Default: "Utilities/Adaptors"

* `node[:webobjects][:webobjects_apache_conf_remote_url]` - Where to get a generic webobjects.conf file. Default: "http://webobjects.s3.amazonaws.com/apache.conf"
* `node[:webobjects][:webobjects_apache_conf_local_name]` - What to call the webobjects.conf file. Default: "webobjects.conf"

* `node[:webobjects][:webobjects_user]` - What user to run WebObjects as. Default: "appserver"
* `node[:webobjects][:webobjects_group]` - What group to run WebObjects as. Default: "appserveradm"
* `node[:webobjects][:webobjects_site_url]` - The publicly facing URL for WebObjects (used for setting the adaptor within JavaMonitor). Default: "http://localhost"
* `node[:webobjects][:webobjects_resources_url]` - The URL path for resources. Default: "/WebObjects"
* `node[:webobjects][:webobjects_apps_url]` - The URL path for WebObjects Applications. Default: "/cgi-bin/WebObjects"
* `node[:webobjects][:webobjects_wotaskd_host]` - The host for wotaskd. Default: "localhost"
* `node[:webobjects][:webobjects_wotaskd_port]` - The port for wotaskd. Default: "1085"
* `node[:webobjects][:webobjects_wotaskd_interval]` - The wotaskd polling interval. Default: "10"
* `node[:webobjects][:webobjects_wotaskd_receive_timeout]` - The wotaskd receive timeout. Default: "5000"
* `node[:webobjects][:webobjects_wotaskd_startup_wait]` - The number of seconds to wait for wotaskd to startup before adding hosts or applications. Default: "10"
* `node[:webobjects][:webobjects_JavaMonitor_host]` - The host for JavaMonitor. Default: "127.0.0.1"
* `node[:webobjects][:webobjects_JavaMonitor_port]` - The port for JavaMonitor. Default: "56789"
* `node[:webobjects][:webobjects_JavaMonitor_receive_timeout]` - The JavaMonitor receive timeout. Default: "10000"

* `node[:webobjects][:webobjects_WOLocalRootDirectory_dir]` - Where to install WebObjects frameworks and runtimes. Default: "/opt"
* `node[:webobjects][:webobjects_WOApplications_dir]` - Where to install yoru WebObjects applications. Default: "/opt/WOApplications"
* `node[:webobjects][:webobjects_WOWebServerResources_dir]` - Where to install web server resources. Default: "/opt/WOWebServerResources"
* `node[:webobjects][:webobjects_WODeployment_dir]` - Where to install the wotaskd and JavaMonitor. Default: "/opt/WODeployment"
* `node[:webobjects][:webobjects_WOLog_dir]` - Where to create log files for wotaskd, JavaMonitor, and individual apps. Default: "/var/log/webobjects"

* `node[:webobjects][:webobjects_JavaMonitor_remote_url]` - Where to download JavaMonitor. Default: "https://s3-eu-west-1.amazonaws.com/webobjects/JavaMonitor.tgz"
* `node[:webobjects][:webobjects_JavaMonitor_local_package]` - What to call JavaMonitor once downloaded. Default: "JavaMonitor.tgz"
* `node[:webobjects][:webobjects_JavaMonitor_app]` - Name of the JavaMonitor app. Default: "JavaMonitor.woa"
* `node[:webobjects][:webobjects_JavaMonitor_password]` - What JavaMonitor password to set. Default: "wonderful"
* `node[:webobjects][:webobjects_wotaskd_remote_url]` - Where to download wotaskd. Default: "https://s3-eu-west-1.amazonaws.com/webobjects/wotaskd.tgz"
* `node[:webobjects][:webobjects_wotaskd_local_package]` - What to call wotaskd once downloaded. Default: "wotaskd.tgz"
* `node[:webobjects][:webobjects_wotaskd_app]` - Name of the wotaskd app. Default: "wotaskd.woa"

* `node[:webobjects][:file_limit]` - The system-wide file limit. Default: "200000"
* `node[:webobjects][:security_limit_hard]` - The users specific hard file limit. Default: "200000"
* `node[:webobjects][:security_limit_soft]` - The users specific sot file limit. Default: "200000"

---
Recipes
=======

default
-------

Does nothing.

build\_apache\_adaptor
--------------------

Downloads the wonder adaptor source, builds, and installs the `mod_WebObjects` module.

compile
-------

Assumes you already have a `ant` build script and simply runs the default target.

deploy\_locally
--------------

Copies the built deployments to the local applications and resources directories, useful for standalone deployments.

deploy\_to\_java_monitor
----------------------

Tells the `JavaMonitor` about the apps location and adds and instance of it.

git\_source
----------

Clones the application source from git, configured via data bags.

modify\_apache\_config
--------------------

Creates an Apache config file from a template.

modify\_system\_file\_limits
-------------------------

Changes the number of open files allowed.

setup\_compile\_environment
-------------------------

Creates a few directories and config files needed fro building WebObjects apps from source

setup\_deployment\_environment
----------------------------

Downloads and installs `wotaskd` and `JavaMonitor`, installs and starts a webobjects service,
and sets JavaMonitor up with a host, site config, and password.


---
Usage
=====

Roles
-----

An example `webobjects_application_server` role which installs WebObjects 5.4 application server (`wotaskd` and `JavaMonitor`):

		name "webobjects_application_server"
		description "A WebObjects application server"
		run_list "recipe[java]", "recipe[webobjects::modify_system_file_limits]", "recipe[webobjects::setup_deployment_environment]"

An example `webobjects_http_server` role which installs an Apache 2 web server and builds a WebObjects adaptor:

		name "webobjects_http_server"
		description "A server which handles HTTP requests and pass them via wonder adapter to a WebObjects application server"
		run_list "recipe[apache2]", "recipe[apache2::mod_ssl]", "recipe[webobjects::build_apache_adaptor]", "recipe[webobjects::modify_apache_config]"

An example `webobjects_compile_server` role which installs resources to compile WebObjects applications from source:

		name "webobjects_compile_server"
		description "A server which compiles WebObjects apps"
		run_list "role[webobjects_application_server]", "recipe[webobjects::setup_compile_environment]"

Note that you must provide the Apple, Wonder, woproject.jar, and other third-party frameworks.

Data Bags
---------

See [this post](http://www.opscode.com/blog/2010/05/06/data-driven-application-deployment-with-chef/)
on the use of Opscode's application deployment cookbooks and the use of data bags.

While this cookbook doesn't directly use any of the deployment recipes in that cookbook it follows
the same precedence there.

There some additional data bag attributes specific to this cookbook:

**app_environment**

		"app_environment": "_default"

sets the general chef environment being used.

**deploy_name**

		"deploy_name": "MyApp"

designates that you're deploying a WebObjects app of `MyApp.woa`.

**application_properties**

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

is how you might manipulate a system properties file from a chef template before deploying.

**Application configuration settings**

	"webobjects_receive_timeout": "240",
	"webobjects_connect_timeout": "240",
	"webobjects_additional_arguments": "-Xmx512m -Xms128m"
	
are settings applied when adding the application to JavaMonitor.

**webobjects_num_instances**

	"webobjects_num_instances": 2
	
is how you could specify that two instances of your application should be created.


Notes
=====

* At the time of this writing there seems to be an issue getting chef-client running on CentOS 5.x images unrelated to
this cookbook.
* This cookbook was adapted from the work done at [ObjectStyle Wiki](http://wiki.objectstyle.org/confluence/display/WO/Platforms)


License and Authors
===================

Author:: Ray Gauss <ray.gauss@rightspro.com>

Copyright:: 2011, RightsPro.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
