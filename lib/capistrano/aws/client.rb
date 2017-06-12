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
          ::Aws::EC2::Client.new(credentials: credentials, region: region)
        end
      )
    end

    def elb
      @elb ||= AutoMapping.new(
        fetch(:aws_regions).map do |region|
          ::Aws::ElasticLoadBalancingV2::Client.new(credentials: credentials, region: region)
        end
      )
    end
  end
end
