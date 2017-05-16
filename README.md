# Capistrano::Aws

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano3-aws'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano3-aws

## Usage

in `Capfile`:

```ruby
require 'capistrano3-aws'
```


in `config/deploy.rb`:

```ruby
set :aws_profile, 'myapp'
set :aws_regions, %w(ap-northeast-1 us-east-1)

set :ec2_filters, -> {
  [ { name: 'tag:Name', ["*#{fetch(:application)}-#{fetch(:ec2_stage)}"] },
    { name: 'tag:Stage', [fetch(:ec2_stage)] },
    { name: 'tag:Role', %w(app db web) },
    { name: 'instance-state-name', values: %w(running) }
  ]
}

task :set_instances do
  hosts = instances.map(&:public_dns_name)
  role :web, hosts
  role :app, hosts
  role :db, hosts.first
end

after :staging, :set_instances
```

in `config/deploy/staging`:

```ruby
set :ec2_stage, 'dev'
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/masarakki/capistrano3-aws.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
