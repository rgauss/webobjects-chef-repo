
name "webobjects_application_server"
description "A WebObjects application server"
run_list "recipe[java]", "recipe[webobjects::modify_system_file_limits]", "recipe[webobjects::setup_deployment_environment]"