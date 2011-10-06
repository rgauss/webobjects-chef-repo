
name "webobjects_application_server"
description "A WebObjects application server"
run_list "recipe[java]", "recipe[webobjects_wonder::modify_system_file_limits]", "recipe[webobjects_wonder::setup_deployment_environment]"