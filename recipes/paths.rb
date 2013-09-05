# configuring the paths requires prerequisites to be fulfilled
include_recipe 'ripple-client::users'

##
# Handles for recipe configuration
##
cfg = CookbookRippleClient::Config
cfg.extract_from_node(node)

deploy_cfg = cfg::Deployment
usr_cfg = deploy_cfg::User
group_cfg = deploy_cfg::Group
app_cfg = deploy_cfg::Application
fs_app_cfg = app_cfg::FilesystemLocations

##
# Configuration paths
##
config_cfg = fs_app_cfg::Configuration

directory config_cfg.root_path do
  group group_cfg.name
end

##
# Source code paths
##
code_cfg = fs_app_cfg::Code

[code_cfg.root_path, code_cfg.shared_files_path].each do |source_directory|
  directory source_directory do
    owner usr_cfg.name
    group group_cfg.name
    mode '0775'
  end
end

##
# Link configuration path into the shared source code resource directory
##

link code_cfg.config_path do
  to config_cfg.root_path
end