
app = node.run_state[:current_app]

script "compile_app_source" do
  interpreter "bash"
  user app['owner']
  cwd "#{app['deploy_to']}/repo"
  code <<-EOH
  ant
  EOH
end