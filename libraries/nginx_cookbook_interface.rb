module CookbookRippleClient
  module ExternalCookbookInterfaces

    # TODO: Similar pattern to configuration.rb. I need to fix this up, it's pretty bad.
    def self.manipulate_node(node)
      $cookbook_ripple_client_external_interface_manipulate_node = node
    end

    def self.node
      $cookbook_ripple_client_external_interface_manipulate_node
    end

    module Nginx

      def self.set_install_method_to_package
        ExternalCookbookInterfaces.node.set['nginx']['install_method'] = 'package'
      end

      def self.set_package_name(package_name)
        ExternalCookbookInterfaces.node.set['nginx']['package_name'] = package_name
      end

      def self.configuration_path
        namespace['dir']
      end

      def self.available_sites_root
        File.join(configuration_path, 'sites-available')
      end

      def self.namespace
        ExternalCookbookInterfaces.node['nginx']
      end

    end

  end
end