#
# Cookbook Name:: webobjects
# Recipe:: deploy_locally
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

app = node.run_state[:current_app]

script "deploy_locally" do
  interpreter "bash"
  user app['owner']
  group app['group']
  cwd "#{app['deploy_to']}/#{node[:webobjects][:deploy_to_repo_path]}"
  code <<-EOH
  tar -xzf #{app['deploy_to']}/#{node[:webobjects][:deploy_to_repo_path]}/dist/#{app['deploy_name']}-Application.tar.gz -C #{node[:webobjects][:webobjects_WOApplications_dir]}
  tar -xzf #{app['deploy_to']}/#{node[:webobjects][:deploy_to_repo_path]}/dist/#{app['deploy_name']}-WebServerResources.tar.gz -C #{node[:webobjects][:webobjects_WOWebServerResources_dir]}
  EOH
end