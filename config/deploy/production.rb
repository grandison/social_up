require 'fileutils'

# set :rvm_type,        :system
# require "rvm/capistrano"

set :application,       "socialup"
set :rails_env,         "production"

server "91.239.26.16", :app, :web, :db, :primary => true

set :user,              "root"
set :domain,            "91.239.26.16"
set :repository,        "git@github.com:grandison/social_up.git"
set :scm,               "git"
set :branch,            "master"
set :deploy_via,        :remote_cache
set :deploy_to,         "/var/www/rails/socialup"
set :use_sudo,          false

set :unicorn_binary,    "/usr/local/bin/unicorn"
set :unicorn_config,    "#{current_path}/config/unicorn.rb"
set :unicorn_pid,       "#{current_path}/tmp/pids/unicorn.pid"

set :normalize_asset_timestamps, false

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} #{try_sudo} bundle exec #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  end

  task :stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} test -e #{unicorn_pid} && kill `cat #{unicorn_pid}`; true"
  end

  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} test -e #{unicorn_pid} && kill -s QUIT `cat #{unicorn_pid}`; true"
  end

  task :reload, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} test -e #{unicorn_pid} && kill -s HUP `cat #{unicorn_pid}`"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    deploy.web.disable
    stop
    start
    deploy.web.enable
  end

  task :customize, :roles => :app do
    run %Q(ln -sf #{shared_path}/config/.rvmrc #{latest_release}/.rvmrc)
    configs = %w(database.yml omniauth.yml unicorn.rb)
    configs.each do |config|
      run %Q(ln -sf #{shared_path}/config/#{config} #{latest_release}/config/#{config})
    end
    run %Q(ln -sf #{shared_path}/uploads #{latest_release}/public/uploads)
  end
end

after 'deploy:finalize_update', 'deploy:customize'

set :keep_releases, 10

after 'deploy', 'deploy:cleanup'
