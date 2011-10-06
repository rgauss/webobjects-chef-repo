
sysctl_file = "/etc/sysctl.conf"
security_limits_file = "/etc/security/limits.conf"
new_limits_file = "#{Chef::Config[:file_cache_path]}/new_system_file_limits.txt"

if !File.exists?(new_limits_file)

  script "wonder_modify_system_file_limit" do
    interpreter "bash"
    user "root"
    code <<-EOH
    cat >> #{sysctl_file} << END
  fs.file-max=#{node[:webobjects][:file_limit]}
    EOH
  end

  script "wonder_modify_user_file_limits" do
    interpreter "bash"
    user "root"
    code <<-EOH
    cat >> #{security_limits_file} << END
  * hard nofile #{node[:webobjects][:security_limit_hard]}
  * soft nofile #{node[:webobjects][:security_limit_soft]}
    EOH
  end

  script "wonder_load_user_file_limits" do
    interpreter "bash"
    user "root"
    code <<-EOH
    cat >> #{security_limits_file} << END
  session    required     pam_limits.so
    EOH
  end

  script "wonder_reload_system_props" do
    interpreter "bash"
    user "root"
    code <<-EOH
  sysctl -p
    EOH
  end

  script "cache_change" do
    interpreter "bash"
    user "root"
    code <<-EOH
  echo "#{node[:webobjects][:file_limit]}" > #{new_limits_file}
    EOH
  end

end
