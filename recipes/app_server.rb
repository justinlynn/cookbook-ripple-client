##
# Recipe configuration handles
##
CookbookRippleClient::Config.extract_from_node(node)
app_server_cfg = CookbookRippleClient::Config::AppServer

##
# Nginx Server Installation
##
CookbookRippleClient::ExternalCookbookInterfaces.manipulate_node(node)
nginx_interface = CookbookRippleClient::ExternalCookbookInterfaces::Nginx
nginx_interface.set_install_method_to_package
nginx_interface.set_package_name('nginx-light')

include_recipe 'nginx'

##
# Site Configuration
##

if app_server_cfg::HTTP.enabled?
  include_recipe 'ripple-client::app_server_http'
end

if app_server_cfg::SSL.enabled?
  include_recipe 'ripple-client::app_server_ssl'
end