

app = node.run_state[:current_app]

script "deploy_locally" do
  interpreter "bash"
  user app['owner']
  cwd "#{app['deploy_to']}/repo"
  code <<-EOH
  tar -xzf #{app['deploy_to']}/repo/dist/#{app['deploy_name']}-Application.tar.gz -C #{node[:webobjects][:webobjects_WOApplications_dir]}
  tar -xzf #{app['deploy_to']}/repo/dist/#{app['deploy_name']}-WebServerResources.tar.gz -C #{node[:webobjects][:webobjects_WOWebServerResources_dir]}
  EOH
end