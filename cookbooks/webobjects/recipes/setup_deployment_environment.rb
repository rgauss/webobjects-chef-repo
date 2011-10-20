#
# Cookbook Name:: webobjects
# Recipe:: setup_deployment_environment
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

user "#{node[:webobjects][:webobjects_user]}" do
  home "/home/#{node[:webobjects][:webobjects_user]}"
  shell "/bin/bash"
  supports :manage_home => true
end
group "#{node[:webobjects][:webobjects_group]}" do
  members [ node[:webobjects][:webobjects_user] ]
end

script "setup_user_environment" do
  interpreter "bash"
  user node[:webobjects][:webobjects_user]
  code <<-EOH
  touch /home/#{node[:webobjects][:webobjects_user]}/.bash_profile
  cat >> /home/#{node[:webobjects][:webobjects_user]}/.bash_profile << END
NEXT_ROOT=#{node[:webobjects][:webobjects_WOLocalRootDirectory_dir]}; export NEXT_ROOT
WOROOT=#{node[:webobjects][:webobjects_WOLocalRootDirectory_dir]}; export WOROOT
  EOH
end


directory "#{node[:webobjects][:webobjects_WOApplications_dir]}" do
  recursive true
  owner node[:webobjects][:webobjects_user]
  group node[:webobjects][:webobjects_group]
  action :create
end
directory "#{node[:webobjects][:webobjects_WOWebServerResources_dir]}" do
  recursive true
  owner node[:webobjects][:webobjects_user]
  group node[:webobjects][:webobjects_group]
  action :create
end
directory "#{node[:webobjects][:webobjects_WOWebServerResources_dir]}/WebObjects" do
  recursive true
  owner node[:webobjects][:webobjects_user]
  group node[:webobjects][:webobjects_group]
  action :create
end
directory "#{node[:webobjects][:webobjects_WODeployment_dir]}" do
  recursive true
  owner node[:webobjects][:webobjects_user]
  group node[:webobjects][:webobjects_group]
  action :create
end
directory "#{node[:webobjects][:webobjects_WODeployment_dir]}/Configuration" do
  recursive true
  owner node[:webobjects][:webobjects_user]
  group node[:webobjects][:webobjects_group]
  action :create
end
directory "#{node[:webobjects][:webobjects_WOLog_dir]}" do
  recursive true
  owner node[:webobjects][:webobjects_user]
  group node[:webobjects][:webobjects_group]
  action :create
end

if !File.exists?("#{node[:webobjects][:webobjects_WODeployment_dir]}/#{node[:webobjects][:webobjects_JavaMonitor_app]}")

  remote_file "#{node[:webobjects][:webobjects_WODeployment_dir]}/#{node[:webobjects][:webobjects_JavaMonitor_local_package]}" do
    source "#{node[:webobjects][:webobjects_JavaMonitor_remote_url]}"
    owner node[:webobjects][:webobjects_user]
    group node[:webobjects][:webobjects_group]
    mode "0744"
  end
  script "webobjects_javamonitor_unpackage_source" do
    interpreter "bash"
    user node[:webobjects][:webobjects_user]
    group node[:webobjects][:webobjects_group]
    cwd "#{node[:webobjects][:webobjects_WODeployment_dir]}"
    code <<-EOH
    tar -zxf #{node[:webobjects][:webobjects_JavaMonitor_local_package]} -C #{node[:webobjects][:webobjects_WODeployment_dir]} --exclude="._*"
    EOH
  end
  file "#{node[:webobjects][:webobjects_WODeployment_dir]}/#{node[:webobjects][:webobjects_JavaMonitor_local_package]}" do
    action :delete
  end

  script "modify_webobjects_deployment_JavaMonitor" do
    interpreter "bash"
    user node[:webobjects][:webobjects_user]
    code <<-EOH
    cat >> /opt/WODeployment/JavaMonitor.woa/Contents/Resources/Properties << END

  WODeploymentConfigurationDirectory=#{node[:webobjects][:webobjects_WODeployment_dir]}/Configuration
  WOLocalRootDirectory=#{node[:webobjects][:webobjects_WOLocalRootDirectory_dir]}
    EOH
  end

end

if !File.exists?("#{node[:webobjects][:webobjects_WODeployment_dir]}/#{node[:webobjects][:webobjects_wotaskd_app]}")

  remote_file "#{node[:webobjects][:webobjects_WODeployment_dir]}/#{node[:webobjects][:webobjects_wotaskd_local_package]}" do
    source "#{node[:webobjects][:webobjects_wotaskd_remote_url]}"
    owner node[:webobjects][:webobjects_user]
    group node[:webobjects][:webobjects_group]
    mode "0744"
  end
  script "webobjects_javamonitor_unpackage_source" do
    interpreter "bash"
    user node[:webobjects][:webobjects_user]
    group node[:webobjects][:webobjects_group]
    cwd "#{node[:webobjects][:webobjects_WODeployment_dir]}"
    code <<-EOH
    tar -zxf #{node[:webobjects][:webobjects_wotaskd_local_package]} -C #{node[:webobjects][:webobjects_WODeployment_dir]} --exclude="._*"
    EOH
  end
  file "#{node[:webobjects][:webobjects_WODeployment_dir]}/#{node[:webobjects][:webobjects_wotaskd_local_package]}" do
    action :delete
  end

  script "modify_webobjects_deployment_wotaskd" do
    interpreter "bash"
    user node[:webobjects][:webobjects_user]
    code <<-EOH
    cat >> #{node[:webobjects][:webobjects_WODeployment_dir]}/wotaskd.woa/Contents/Resources/Properties << END

  WODeploymentConfigurationDirectory=#{node[:webobjects][:webobjects_WODeployment_dir]}/Configuration
  WOLocalRootDirectory=#{node[:webobjects][:webobjects_WOLocalRootDirectory_dir]}
  WOTaskd.receiveTimeout=#{node[:webobjects][:webobjects_wotaskd_receive_timeout]}
  JavaMonitor.receiveTimeout=#{node[:webobjects][:webobjects_JavaMonitor_receive_timeout]}
    EOH
  end
  
  template "#{node[:webobjects][:webobjects_WODeployment_dir]}/wotaskd.woa/Contents/Resources/SpawnOfWotaskd.sh" do
    source "SpawnOfWotaskd.sh.erb"
    owner node[:webobjects][:webobjects_user]
    group node[:webobjects][:webobjects_group]
    mode "0750"
  end

end


file "#{node[:webobjects][:webobjects_WODeployment_dir]}/JavaMonitor.woa/JavaMonitor" do
  mode "0750"
end
file "#{node[:webobjects][:webobjects_WODeployment_dir]}/wotaskd.woa/Contents/Resources/SpawnOfWotaskd.sh" do
  mode "0750"
end
file "#{node[:webobjects][:webobjects_WODeployment_dir]}/wotaskd.woa/wotaskd" do
  mode "0750"
end


javamonitor_needs_setup = false

if !File.exists?("/etc/init.d/webobjects")
  template "/etc/init.d/webobjects" do
    source "wo-webobjects.initd.erb"
    mode "0755"
    notifies :start, "service[webobjects]", :immediately
  end
  javamonitor_needs_setup = true
end

service "webobjects" do
  action :enable
end

if javamonitor_needs_setup
  script "setup_java_monitor" do
    interpreter "bash"
    code <<-EOH
    sleep #{node[:webobjects][:webobjects_wotaskd_startup_wait]}
    curl -X POST -d "{id: '#{node[:webobjects][:webobjects_JavaMonitor_host]}',type: 'MHost', osType: 'UNIX',address: '#{node[:webobjects][:webobjects_JavaMonitor_host]}', name: '#{node[:webobjects][:webobjects_JavaMonitor_host]}'}" http://#{node[:webobjects][:webobjects_JavaMonitor_host]}:#{node[:webobjects][:webobjects_JavaMonitor_port]}/cgi-bin/WebObjects/JavaMonitor.woa/ra/mHosts.json
    curl -X PUT -d "{woAdaptor:'#{node[:webobjects][:webobjects_site_url]}#{node[:webobjects][:webobjects_apps_url]}'}" http://#{node[:webobjects][:webobjects_JavaMonitor_host]}:#{node[:webobjects][:webobjects_JavaMonitor_port]}/cgi-bin/WebObjects/JavaMonitor.woa/ra/mSiteConfig.json
    curl -X PUT -d "{password:'#{node[:webobjects][:webobjects_JavaMonitor_password]}'}" http://#{node[:webobjects][:webobjects_JavaMonitor_host]}:#{node[:webobjects][:webobjects_JavaMonitor_port]}/cgi-bin/WebObjects/JavaMonitor.woa/ra/mSiteConfig.json
    EOH
  end
  javamonitor_needs_setup = false
end