##
# Handles for configuration
##
cfg = CookbookRippleClient::Config
cfg.extract_from_node(node)

deploy_cfg = cfg::Deployment

deploy_app_cfg = deploy_cfg::Application
deploy_cs_cfg = deploy_app_cfg::CodeSource
deploy_fs_cfg = deploy_app_cfg::FilesystemLocations

deploy_fs_code_cfg = deploy_fs_cfg::Code

deploy_usr_cfg = deploy_cfg::User
deploy_grp_cfg = deploy_cfg::Group

artifact_deploy 'ripple-client' do

  version deploy_cs_cfg.version
  artifact_location deploy_cs_cfg.package_url
  deploy_to deploy_fs_code_cfg.root_path

  owner 'root'
  group deploy_grp_cfg.name

  symlinks({
    'config/config.js' => 'config.js'
  })

  before_extract(Proc.new do

    # Verify the signature

    package 'gnupg'

    execute 'retrieve signing public key' do
      command "gpg --keyserver pgp.mit.edu --recv-keys #{deploy_cs_cfg.package_signing_key_id}"
    end

    remote_file '/tmp/ripple-client-signature' do
      source deploy_cs_cfg.package_gpg_signature_url
    end

    execute 'verify the signature' do
      command "gpg --verify /tmp/ripple-client-signature #{cached_tar_path}"
    end

  end)

  force true
end