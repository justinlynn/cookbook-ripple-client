default_as = default['ripple']['client']['app_server']

##
# HTTP
##
default_http = default_as['http']

default_http['is_enabled'] = true
default_http['server_name'] = '_'

##
# SSL
##
default_ssl = default_as['ssl']

default_ssl['is_enabled'] = true
default_ssl['server_name'] = '_'
default_ssl['endpoint_port'] = 443

# Certificates
default_ssl_certificate = default_ssl['certificate']

default_ssl_certificate['generate_and_use_selfsigned'] = true