namespace :load do
  task :defaults do

    set :aws_profile, nil
    set :aws_access_key_id, nil
    set :aws_secret_access_key, nil
    set :aws_regions, []
  end
end
