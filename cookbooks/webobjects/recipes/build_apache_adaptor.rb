#
# Cookbook Name:: webobjects
# Recipe:: build_apache_adaptor
#
# Copyright 2011, RightsPro.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
if !File.exists?("#{node[:apache][:lib_dir]}/modules/mod_WebObjects.so")

  include_recipe "build-essential"

  if platform?("debian", "ubuntu")
    package "apache2-dev"
  elsif platform?("redhat", "centos", "scientific", "fedora", "arch")
    package "httpd-devel"
  end


  directory "#{Chef::Config[:file_cache_path]}/wonder" do
    recursive true
    action :create
  end


  remote_file "#{Chef::Config[:file_cache_path]}/wonder/#{node[:webobjects][:wonder_source_local_package]}" do
    source "#{node[:webobjects][:wonder_source_remote_url]}"
    action :create_if_missing
  end


  script "wonder_unpackage_source" do
    interpreter "bash"
    user "root"
    cwd "#{Chef::Config[:file_cache_path]}/wonder"
    code <<-EOH
    tar -zxf #{node[:webobjects][:wonder_source_local_package]}
    chmod -R 777 #{node[:webobjects][:wonder_source_dir_Utilities]}
    EOH
  end


  if platform?("debian", "ubuntu")
    apache_extension_tool = "apxs2"
  elsif platform?("redhat", "centos", "scientific", "fedora", "arch")
    apache_extension_tool = "apxs"
  end
  script "wonder_build_adaptor" do
    interpreter "bash"
    user "root"
    cwd "#{Chef::Config[:file_cache_path]}/wonder/#{node[:webobjects][:wonder_source_dir_Adaptors]}"
    code <<-EOH
    sed --in-place=.backup 's/ADAPTOR_OS = MACOS/ADAPTOR_OS = LINUX/g' make.config
    make CC=gcc
    cd Apache2.2/
    #{apache_extension_tool} -i -a -n WebObjects mod_WebObjects.la
    EOH
  end

  directory "#{Chef::Config[:file_cache_path]}/wonder" do
    recursive true
    action :delete
  end

end