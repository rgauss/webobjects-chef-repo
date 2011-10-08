
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