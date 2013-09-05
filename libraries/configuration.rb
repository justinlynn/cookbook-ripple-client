module CookbookRippleClient

  ##
  # Convenience functions for accessing recipe configuration. Reduces duplication in extracting relevant node
  # attributes. Provides common space for calculated attributes.
  ##
  module Config

    # TODO: sorry mates, this is extraordinarily ugly but because this is all used during the serial compilation
    # phase it's not as big a problem as it first appears.
    def self.extract_from_node(node)
      $cookbook_ripple_client_node = node
    end

    def self.cfg
      $cookbook_ripple_client_node['ripple']['client']
    end

    module Client

      def self.cfg
        Config.cfg['client']
      end

    end

    module AppServer

      module HTTP

        def self.server_name
          cfg['server_name']
        end

        def self.enabled?
          cfg['is_enabled']
        end

        def self.cfg
          AppServer.cfg['http']
        end

      end

      module SSL

        module Certificate

          def self.generate_and_use_selfsigned?
            cfg['generate_and_use_selfsigned']
          end

          def self.cfg
            SSL.cfg['certificate']
          end

        end

        def self.endpoint_port
          cfg['endpoint_port']
        end

        def self.server_name
          cfg['server_name']
        end

        def self.enabled?
          cfg['is_enabled']
        end

        def self.cfg
          AppServer.cfg['ssl']
        end

      end

      def self.cfg
        Config.cfg['app_server']
      end

    end

    module Deployment

      module Application

        module CodeSource

          def self.package_signing_key_id
            cfg['package_signing_key_id']
          end

          def self.package_gpg_signature_url
            package_url + '.sig'
          end

          def self.package_url
            cfg['url']
          end

          def self.version
            cfg['version']
          end

          def self.cfg
            Application.cfg['code_source']
          end

        end

        module FilesystemLocations

          module Configuration

            def self.root_path
              cfg
            end

            def self.cfg
              FilesystemLocations.cfg['configuration']
            end

          end

          module Code

            RELEASES_PATH = 'releases'
            SHARED_FILES_PATH = 'shared'
            CURRENT_RELEASE_PATH = 'current'
            CONFIGURATION_PATH = File.join(SHARED_FILES_PATH, 'config')

            def self.root_path
              cfg
            end

            def self.current_release_path
              File.join(root_path, CURRENT_RELEASE_PATH)
            end

            def self.config_path
              File.join(root_path, CONFIGURATION_PATH)
            end

            def self.shared_files_path
              File.join(root_path, SHARED_FILES_PATH)
            end

            def self.cfg
              FilesystemLocations.cfg['code']
            end

          end

          def self.cfg
            Application.cfg['filesystem_locations']
          end

        end

        def self.cfg
          Deployment.cfg['application']
        end

      end

      module Group

        def self.name
          cfg['name']
        end

        def self.id
          cfg['id']
        end

        def self.additional_members
          cfg['additional_members']
        end

        def self.cfg
          Deployment.cfg['group']
        end

      end

      module User

        def self.name
          cfg['name']
        end

        def self.id
          cfg['id']
        end

        def self.cfg
          Deployment.cfg['user']
        end

      end

      def self.cfg
        Config.cfg['deployment']
      end

    end
    
  end

end
