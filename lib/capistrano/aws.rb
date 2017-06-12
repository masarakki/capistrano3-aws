require 'aws-sdk'
require 'capistrano/aws/version'
require 'capistrano/aws/client'
load File.expand_path("../aws/tasks/aws.rake", __FILE__)

module Capistrano
  module Aws
    def instances(options = {})
      ec2.describe_instances(filters: fetch(:ec2_filters)).reservations.instances
    end

    def bluegreen(role, target_arn, &block)
      servers = roles(role)
      servers.each_slice(servers.length / 2).each do |cluster|
        begin
          instance_ids = cluster.map{|x| x.properties.instance_id }
          deregister(target_arn, instance_ids)
          on(cluster, &block)
        ensure
          register(target_arn, instance_ids)
        end
      end
    end

    def register(target_arn, instance_ids)
      params = {
        target_group_arn: target_arn,
        targets: instance_ids.map{|id| { id: id }}
      }

      elb.register_targets(params)
      loop do
        return if elb.describe_target_health(params).target_health_descriptions.all? { |t| t.target_health.state == 'healthy' }
        sleep 5
      end
    end

    def deregister(target_arn, instance_ids)
      params = {
        target_group_arn: target_arn,
        targets: instance_ids.map{|id| { id: id }}
      }

      elb.deregister_targets(params)
      loop do
        return if elb.describe_target_health(params).target_health_descriptions.all? { |t| t.target_health.state == 'unused' }
        sleep 5
      end
    end
  end
end

self.extend Capistrano::Aws
