cfg = CookbookRippleClient::Config
cfg.extract_from_node(node)

deploy_cfg = cfg::Deployment

##
# Create deployment group, this allows us to grant other users on the system access
# to application resources.
##
group_cfg = deploy_cfg::Group

group group_cfg.name do
  gid group_cfg.id
  members group_cfg.additional_members
  append true # so that we do not overwrite our deploy user with additional_members on rerun
end

##
# Manage deployment user, we store files in the filesystem owned by this user id
##
usr_cfg = deploy_cfg::User

user usr_cfg.name do
  uid usr_cfg.id
  group group_cfg.name
  # this user should not log in
  system true
end