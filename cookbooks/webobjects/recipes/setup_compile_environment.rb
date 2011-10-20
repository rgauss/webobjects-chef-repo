#
# Cookbook Name:: webobjects
# Recipe:: setup_compile_environment
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

if !File.exists?("/home/#{node[:webobjects][:webobjects_user]}/Library/Application\ Support/WOLips/wolips.properties")

  directory "/home/#{node[:webobjects][:webobjects_user]}/Library/Application\ Support/WOLips" do
    owner node[:webobjects][:webobjects_user]
    group node[:webobjects][:webobjects_group]
    mode "0755"
    recursive true
  end

  template "/home/#{node[:webobjects][:webobjects_user]}/Library/Application\ Support/WOLips/wolips.properties" do
    source "wolips.properties.erb"
    owner node[:webobjects][:webobjects_user]
    group node[:webobjects][:webobjects_group]
    mode "0744"
  end

end

if !File.exists?("#{node[:webobjects][:webobjects_WOLocalRootDirectory_dir]}/Extensions")

  directory "#{node[:webobjects][:webobjects_WOLocalRootDirectory_dir]}/Extensions" do
    owner node[:webobjects][:webobjects_user]
    group node[:webobjects][:webobjects_group]
    mode "0755"
    recursive true
  end

end

if !File.exists?("#{node[:webobjects][:webobjects_WOLocalRootDirectory_dir]}/Local/Library/Frameworks")

  directory "#{node[:webobjects][:webobjects_WOLocalRootDirectory_dir]}/Local" do
      owner node[:webobjects][:webobjects_user]
      group node[:webobjects][:webobjects_group]
      mode "0755"
      recursive true
  end
  directory "#{node[:webobjects][:webobjects_WOLocalRootDirectory_dir]}/Local/Library" do
    owner node[:webobjects][:webobjects_user]
    group node[:webobjects][:webobjects_group]
    mode "0755"
    recursive true
  end
  directory "#{node[:webobjects][:webobjects_WOLocalRootDirectory_dir]}/Local/Library/Frameworks" do
    owner node[:webobjects][:webobjects_user]
    group node[:webobjects][:webobjects_group]
    mode "0755"
    recursive true
  end

end

if !File.exists?("#{node[:webobjects][:webobjects_WOLocalRootDirectory_dir]}/Library/Frameworks")

  directory "#{node[:webobjects][:webobjects_WOLocalRootDirectory_dir]}/Library" do
    owner node[:webobjects][:webobjects_user]
    group node[:webobjects][:webobjects_group]
    mode "0755"
    recursive true
  end
  directory "#{node[:webobjects][:webobjects_WOLocalRootDirectory_dir]}/Library/Frameworks" do
    owner node[:webobjects][:webobjects_user]
    group node[:webobjects][:webobjects_group]
    mode "0755"
    recursive true
  end

end