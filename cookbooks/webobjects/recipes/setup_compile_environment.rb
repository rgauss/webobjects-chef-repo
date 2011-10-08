
if !File.exists?("/home/#{node[:webobjects][:webobjects_user]}/Library/wobuild.properties")

  directory "/home/#{node[:webobjects][:webobjects_user]}/Library" do
    owner node[:webobjects][:webobjects_user]
    group node[:webobjects][:webobjects_group]
    mode "0755"
    recursive true
  end

  template "/home/#{node[:webobjects][:webobjects_user]}/Library/wobuild.properties" do
    source "wobuild.properties.erb"
    owner node[:webobjects][:webobjects_user]
    group node[:webobjects][:webobjects_group]
    mode "0744"
  end

end

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

  directory "#{node[:webobjects][:webobjects_WOLocalRootDirectory_dir]}/Local/Library/Frameworks" do
    owner node[:webobjects][:webobjects_user]
    group node[:webobjects][:webobjects_group]
    mode "0755"
    recursive true
  end

end

if !File.exists?("#{node[:webobjects][:webobjects_WOLocalRootDirectory_dir]}/Library/Frameworks")

  directory "#{node[:webobjects][:webobjects_WOLocalRootDirectory_dir]}/Library/Frameworks" do
    owner node[:webobjects][:webobjects_user]
    group node[:webobjects][:webobjects_group]
    mode "0755"
    recursive true
  end

end