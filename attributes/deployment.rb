default_deployment = default['ripple']['client']['deployment']

##
# Application
##
default_app = default_deployment['application']

# CodeSource

default_cs = default_app['code_source']

default_cs['version'] = 'cfea2c99e8b43306bed43d8726598b843c1f282d-1'

default_cs['url'] = "https://s3-us-west-2.amazonaws.com/j-ripple-client-dist/ripple-client-dist-cfea2c99e8b43306bed43d8726598b843c1f282d-1.zip"
default_cs['package_signing_key_id'] = '81303E6A'

# FilesystemLocations

default_fsl = default_app['filesystem_locations']

default_fsl['code'] = '/opt/ripple-client'
default_fsl['configuration'] = '/etc/ripple-client'

##
# User
##
default_user = default_deployment['user']

default_user['name'] = 'ripple-client'
default_user['id'] = 6000

##
# Group
##
default_group = default_deployment['group']

default_group['name'] = 'ripple-client'
default_group['id'] = 6000

# nginx is an implicit member of the ripple-client group
# as it needs read-only access to serve the files
default_group['additional_members'] = []