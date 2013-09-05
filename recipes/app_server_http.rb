##
# Recipe configuration handles
##

CookbookRippleClient::Config.extract_from_node(node)

cfg = CookbookRippleClient::Config

deploy_cfg = cfg::Deployment

deploy_usr_cfg = deploy_cfg::User
deploy_grp_cfg = deploy_cfg::Group

deploy_app_cfg = deploy_cfg::Application
deploy_fs_cfg = deploy_app_cfg::FilesystemLocations
deploy_fs_code_cfg = deploy_fs_cfg::Code

app_server_cfg = cfg::AppServer
app_server_http_cfg = app_server_cfg::HTTP
app_server_ssl_cfg = app_server_cfg::SSL

##
# Query for information from Nginx Recipe
##

CookbookRippleClient::ExternalCookbookInterfaces.manipulate_node(node)
nginx_interface = CookbookRippleClient::ExternalCookbookInterfaces::Nginx
nginx_sites_available_dir_root = nginx_interface.available_sites_root

##
# Write site configuration template
##

site_name = 'ripple-client-http'

template File.join(nginx_sites_available_dir_root, site_name) do
  source 'nginx_http_site.conf.erb'
  variables({
    :ssl_is_enabled => app_server_ssl_cfg.enabled?,
    :application_user => deploy_usr_cfg.name,
    :application_group => deploy_grp_cfg.name,
    :application_root => deploy_fs_code_cfg.current_release_path,
    :server_name => app_server_ssl_cfg.server_name,
    :ssl_endpoint_port => app_server_ssl_cfg.endpoint_port
  })
end

##
# Enable site
##

nginx_site site_name