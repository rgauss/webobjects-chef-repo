maintainer       "RightsPro"
maintainer_email "ray.gauss@rightspro.com"
license          "Apache 2.0"
description      "Installs and configures a WebObjects service (wotaskd and JavaMonitor) and Apache adaptor"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.2"

depends "apache2"
depends "build-essential"
depends "java"
depends "apt"

recipe "webobjects", "Does nothing"
recipe "webobjects::build_apache_adaptor", "Installs the OpenJDK flavor of Java"
recipe "java::sun", "Installs the Sun flavor of Java"

recipe "webobjects::build_apache_adaptor", "Downloads the wonder adaptor source, builds, and installs the mod_WebObjects module"
recipe "webobjects::compile", "Assumes you already have a `ant` build script and simply runs the default target"
recipe "webobjects::deploy_locally", "copies the built deployments to the local applications and resources directories, useful for standalone deployments"
recipe "webobjects::deploy_to_java_monitor", "Tells the JavaMonitor about the apps location and adds instances of it"
recipe "webobjects::git_source", "Clones the application source from git, configured via data bags"
recipe "webobjects::modify_apache_config", "Creates an Apache config file from a template"
recipe "webobjects::modify_system_file_limits", "Changes the number of open files allowed"
recipe "webobjects::setup_compile_environment", "Creates a few directories and config files needed fro building WebObjects apps from source"
recipe "webobjects::setup_deployment_environment", "Downloads and installs wotaskd and JavaMonitor, installs and starts a webobjects service, and sets JavaMonitor up with a host, site config, and password"

%w{ debian ubuntu centos redhat fedora }.each do |os|
  supports os
end