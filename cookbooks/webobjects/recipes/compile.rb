#
# Cookbook Name:: webobjects
# Recipe:: compile
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

script "compile_app_source" do
  interpreter "bash"
  user app['owner']
  group app['group']
  cwd "#{app['deploy_to']}/#{node[:webobjects][:deploy_to_repo_application_path]}"
  code <<-EOH
  ant
  EOH
end