require 'aws-sdk'
require 'capistrano/aws/version'
require 'capistrano/aws/client'
load File.expand_path("../aws/tasks/aws.rake", __FILE__)

module Capistrano
  module Aws
    def instances(options = {})
      ec2.describe_instances(filters: fetch(:ec2_filters)).reservations.instances
    end
  end
end

self.extend Capistrano::Aws
