# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :stages, %w(master development staging production)
set :application, 'test_project'
set :repo_url, "git@github.com:zkdlwnfm/test_project.git"
set :deploy_to, "/usr/share/nginx/html/#{fetch(:application)}"
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.6.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all
set :shared_children, %w(log config system upload)
set :default_shell, :bash

# default values # Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :config_files, fetch(:linked_files)
set :pty, true
set :keep_releases, 5

#before 'deploy:check:linked_files', 'config:push'

namespace :deploy do
  task :copy_config do
    on release_roles :app do |role|
      fetch(:linked_files).each do |linked_file|
        user = role.user + "@" if role.user
        hostname = role.hostname
        linked_files(shared_path).each do |file|
          run_locally do
            execute :rsync, "config/#{file.to_s.gsub(/.*\/(.*)$/,"\\1")}", "#{user}#{hostname}:#{file.to_s.gsub(/(.*)\/[^\/]*$/, "\\1")}/"
          end
        end
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      # execute :rake, 'cache:clear'
      # end
    end
  end
end
before "deploy:check:linked_files", "deploy:copy_config"
set :keep_releases, 5

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
