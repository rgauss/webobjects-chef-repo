#
# Cookbook Name:: webobjects
# Recipe:: modify_apache_config
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
if !File.exists?("#{node[:apache][:dir]}/conf.d/#{node[:webobjects][:webobjects_apache_conf_local_name]}")

  template "#{node[:apache][:dir]}/conf.d/#{node[:webobjects][:webobjects_apache_conf_local_name]}" do
    source "webobjects.conf.erb"
    owner node[:apache][:user]
    group node[:apache][:group]
    mode "0744"
  end

end

service "apache2" do
  action :restart
end