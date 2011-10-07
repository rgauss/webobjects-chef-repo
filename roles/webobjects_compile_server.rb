
name "webobjects_compile_server"
description "A server which compiles WebObjects apps"
run_list "role[webobjects_application_server]", "recipe[webobjects::setup_compile_environment]"