rails_env = ENV['RAILS_ENV'] || 'production'
worker_processes case rails_env
  when 'production'
    4
  when 'mybodedrinks'
    2
  else
    1
  end

base_dir = case rails_env
  when 'production'
    '/var/www/vemmabode.com'
  when 'mybodedrinks'
    '/var/www/mybodedrinks.com'
  else
    '/var/www/vbodedev.com'
  end

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

timeout 30
listen "#{base_dir}/shared/tmp/socialup.socket"
pid "#{base_dir}/current/tmp/pids/unicorn.pid"
stderr_path "#{base_dir}/shared/log/unicorn.stderr.log"
stdout_path "#{base_dir}/shared/log/unicorn.stdout.log"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection

  port = 1 + worker.nr
  child_pid = server.config[:pid].sub('.pid', ".#{port}.pid")
  system("echo #{Process.pid} > #{child_pid}")
end
