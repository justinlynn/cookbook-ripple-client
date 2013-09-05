##
# Recipe configuration handles
##
cfg = CookbookRippleClient::Config
cfg.extract_from_node(node)

deploy_cfg = cfg::Deployment

deploy_usr_cfg = deploy_cfg::User
deploy_grp_cfg = deploy_cfg::Group

deploy_app_cfg = deploy_cfg::Application
deploy_fs_cfg = deploy_app_cfg::FilesystemLocations
deploy_fs_code_cfg = deploy_fs_cfg::Code

app_server_cfg = cfg::AppServer
app_server_ssl_cfg = app_server_cfg::SSL

##
# Certificate management
##

as_cert_cfg = app_server_ssl_cfg::Certificate

certificate_path, key_path = if(as_cert_cfg.generate_and_use_selfsigned?)

  package 'ssl-cert'

  execute 'make-ssl-cert generate-default-snakeoil' do
    creates '/etc/ssl/certs/ssl-cert-snakeoil.pem'
  end

  [ '/etc/ssl/certs/ssl-cert-snakeoil.pem', '/etc/ssl/private/ssl-cert-snakeoil.key' ]

else

  raise 'Not using selfsigned certificate is currently unsupported'

end

##
# Query for information from Nginx Recipe
##

CookbookRippleClient::ExternalCookbookInterfaces.manipulate_node(node)
nginx_interface = CookbookRippleClient::ExternalCookbookInterfaces::Nginx
nginx_sites_available_dir_root = nginx_interface.available_sites_root

##
# Write site configuration template
##

site_name = 'ripple-client-ssl'

template File.join(nginx_sites_available_dir_root, site_name) do
  source 'nginx_ssl_site.conf.erb'
  variables({
                :application_user => deploy_usr_cfg.name,
                :application_group => deploy_grp_cfg.name,
                :application_root => deploy_fs_code_cfg.current_release_path,
                :server_name => app_server_ssl_cfg.server_name,
                :ssl_cert => certificate_path,
                :ssl_cert_key => key_path
            })
end

##
# Enable site
##

nginx_site site_name