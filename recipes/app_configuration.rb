##
# Recipe configuration handles
##
cfg = CookbookRippleClient::Config
cfg.extract_from_node(node)

client_cfg = CookbookRippleClient::Config::Client

deploy_cfg = cfg::Deployment
usr_cfg = deploy_cfg::User
grp_cfg = deploy_cfg::Group
app_cfg = deploy_cfg::Application
fs_app_cfg = app_cfg::FilesystemLocations
fs_app_configuration_cfg = fs_app_cfg::Configuration

template File.join(fs_app_configuration_cfg.root_path, 'config.js') do
  source 'config.js.erb'

  owner 'root'
  group grp_cfg.name

  mode '0644'

  variables({
  })
end