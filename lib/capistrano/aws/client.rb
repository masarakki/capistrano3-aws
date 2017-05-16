module Capistrano
  module Aws
    class AutoMapping < Array
      def method_missing(name, *args, &block)
        AutoMapping.new(self.map {|item| item.send(name, *args, &block) }.flatten(1))
      end
    end

    module_function

    def credentials
      @credentials ||= ::Aws::SharedCredentials.new(profile_name: fetch(:aws_profile)).credentials
    end

    def ec2
      @ec2 ||= AutoMapping.new(
        fetch(:aws_regions).map do |region|
          ::Aws::EC2::Client.new(access_key_id: credentials.access_key_id,
                                 secret_access_key: credentials.secret_access_key,
                                 region: region)
        end
      )
    end
  end
end
