require 'bundler/capistrano'

server 'ec2-54-221-54-139.compute-1.amazonaws.com', :app, :web, :db, primary: true

set :application, "social_up"
set :user, "ubuntu"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository,  "git@github.com:grandison/social_up.git"
set :branch, "master"

set :keep_releases, 5
set :rails_env, 'production'

set :default_environment, {
  "PATH" => "/home/#{user}/.rbenv/shims:/home/#{user}/.rbenv/bin:$PATH",
}

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:auth_methods] = "publickey"
ssh_options[:keys] = ["/home/helloworld/.ssh/oms_keypair.pem"]
ssh_options[:auth_methods] = ["publickey"]

after "deploy", "deploy:migrate"
after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx_prod.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init_prod.sh /etc/init.d/unicorn_#{application}"

    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end