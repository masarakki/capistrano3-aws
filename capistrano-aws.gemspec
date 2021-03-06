# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/aws/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano3-aws"
  spec.version       = Capistrano::Aws::VERSION
  spec.authors       = ["masarakki"]
  spec.email         = ["masaki182@gmail.com"]

  spec.summary       = 'capistrano with aws'
  spec.description   = 'capistrano with aws'
  spec.homepage      = 'https://github.com/masarakki/capistrano3-aws'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'aws-sdk', '~> 2.0'
  spec.add_dependency 'capistrano', '~> 3.0'
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'pry'
end
