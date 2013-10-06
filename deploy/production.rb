require 'fileutils'

set :rvm_type,        :system
set :rvm_ruby_string, 'ree-1.8.7-2011.03@vemmabode'
require "rvm/capistrano"

set :application,       "bod-e"
set :rails_env,         "production"

server "vemmabode.com", :app, :web, :db, :primary => true

set :user,              "vemmabode"
set :domain,            "vemmabode.com"
set :repository,        "git@github.com:AndreyChernyh/bod-e.git"
set :scm,               "git"
set :branch,            "master"
set :deploy_via,        :remote_cache
set :deploy_to,         "/var/www/vemmabode.com"
set :use_sudo,          false

set :unicorn_binary,    "/usr/local/rvm/gems/ree-1.8.7-2011.03/bin/unicorn_rails"
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
    run "sudo monit -g delayed_job restart"
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

after "deploy:restart",         "delayed_job:restart"
after 'deploy:finalize_update', 'deploy:customize'

set :keep_releases, 10

after 'deploy', 'deploy:cleanup'

task :notify_rollbar, :roles => :app do
  set :revision, `git log -n 1 --pretty=format:"%H"`
  set :local_user, `whoami`
  set :rollbar_token, '961887a4f6b54b8fa9d13914de27a7e1'
  rails_env = fetch(:rails_env, 'production')
  run "curl https://api.rollbar.com/api/1/deploy/ -F access_token=#{rollbar_token} -F environment=#{rails_env} -F revision=#{revision} -F local_username=#{local_user} >/dev/null 2>&1", :once => true
end

after 'deploy', 'notify_rollbar'
