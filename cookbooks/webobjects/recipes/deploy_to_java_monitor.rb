
app = node.run_state[:current_app]

receive_timeout_string = ""
if !app['webobjects_receive_timeout'].nil?
  receive_timeout_string = ", recvTimeout: '#{app['webobjects_receive_timeout']}'"
end
connect_timeout_string = ""
if !app['webobjects_connect_timeout'].nil?
  connect_timeout_string = ", cnctTimeout: '#{app['webobjects_connect_timeout']}'"
end
  
script "deploy_to_java_monitor" do
  interpreter "bash"
  code <<-EOH
  curl -X DELETE http://#{node[:webobjects][:webobjects_JavaMonitor_host]}:#{node[:webobjects][:webobjects_JavaMonitor_port]}/#{node[:webobjects][:webobjects_apps_url]}/JavaMonitor.woa/ra/mApplications/#{app['deploy_name']}?pw=#{node[:webobjects][:webobjects_JavaMonitor_password]}
  curl -X POST -d "{id: '#{app['deploy_name']}',type: 'MApplication', name: '#{app['deploy_name']}', unixOutputPath: '#{node[:webobjects][:webobjects_WOLog_dir]}', unixPath: '#{node[:webobjects][:webobjects_WOApplications_dir]}/#{app['deploy_name']}.woa/#{app['deploy_name']}'#{receive_timeout_string}#{connect_timeout_string}}" http://#{node[:webobjects][:webobjects_JavaMonitor_host]}:#{node[:webobjects][:webobjects_JavaMonitor_port]}/#{node[:webobjects][:webobjects_apps_url]}/JavaMonitor.woa/ra/mApplications.json?pw=#{node[:webobjects][:webobjects_JavaMonitor_password]}
  curl -X GET http://#{node[:webobjects][:webobjects_JavaMonitor_host]}:#{node[:webobjects][:webobjects_JavaMonitor_port]}/#{node[:webobjects][:webobjects_apps_url]}/JavaMonitor.woa/ra/mApplications/#{app['deploy_name']}/addInstance?pw=#{node[:webobjects][:webobjects_JavaMonitor_password]}
  EOH
end