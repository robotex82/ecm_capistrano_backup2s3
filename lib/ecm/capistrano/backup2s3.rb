require 'ecm/capistrano/common'

unless Capistrano::Configuration.respond_to?(:instance)
  abort "capistrano/ext/multistage requires Capistrano 2"
end

Capistrano::Configuration.instance.load do
  namespace :backup do
    desc "Creates a backup and moves it to amazon s3"
    task :create, :roles => :app do
      run <<-CMD
        cd #{current_path};
        bundle exec rake RAILS_ENV=#{stage} backup2s3:backup:create
      CMD
    end
  end
end  
