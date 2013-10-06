set :application, "bod-e"
set :rails_env, "staging"

server "vbodedev.com", :app, :web, :db, :primary => true

set :user, "ubuntu"
set :domain, "vbodedev.com"
set :repository, "git@github.com:AndreyChernyh/bod-e.git"
set :scm, "git"
set :branch, "devel"
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/vbodedev.com"
set :use_sudo, false

set :unicorn_binary, "/opt/ruby-enterprise-1.8.7-2011.03/bin/unicorn_rails"
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

set :normalize_asset_timestamps, false

load(File.dirname(__FILE__)  + '/common_tasks')

after 'deploy', 'deploy:cleanup'
