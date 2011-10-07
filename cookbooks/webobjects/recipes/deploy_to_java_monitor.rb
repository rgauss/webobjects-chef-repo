
app = node.run_state[:current_app]

script "deploy_to_java_monitor" do
  interpreter "bash"
  code <<-EOH
  curl -X POST -d "{id: '#{app['deploy_name']}',type: 'MApplication', name: '#{app['deploy_name']}',unixOutputPath: '', unixPath: '#{node[:webobjects][:webobjects_WOApplications_dir]}/#{app['deploy_name']}.woa/#{app['deploy_name']}'}" http://#{node[:webobjects][:webobjects_JavaMonitor_host]}:#{node[:webobjects][:webobjects_JavaMonitor_port]}/cgi-bin/WebObjects/JavaMonitor.woa/ra/mApplications.json?passwd=#{node[:webobjects][:webobjects_JavaMonitor_password]}
  curl -X GET http://#{node[:webobjects][:webobjects_JavaMonitor_host]}:#{node[:webobjects][:webobjects_JavaMonitor_port]}/cgi-bin/WebObjects/JavaMonitor.woa/ra/mApplications/#{app['deploy_name']}/addInstance?passwd=#{node[:webobjects][:webobjects_JavaMonitor_password]}
  EOH
end