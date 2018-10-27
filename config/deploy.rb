# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "annict"
set :repo_url, "git@github.com:annict/annict.git"
set :branch, :aws

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/annict"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# Set false for Sidekiq
# https://github.com/seuros/capistrano-sidekiq#known-issues-with-capistrano-3
set :pty, false

set :default_env,
  "PATH": "/home/annict/.nvm/versions/node/v8.12.0/bin:$PATH",
  "NODE_ENV": "production"

# Default value for :linked_files is []
append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
append :linked_dirs,
  ".bundle",
  "log",
  "node_modules",
  "public/packs",
  "tmp/pids",
  "tmp/cache",
  "tmp/sockets"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :bundle_jobs, 2

set :rbenv_type, :user
set :rbenv_ruby, "2.5.3"

set :nvm_type, :user # or :system, depends on your nvm setup
set :nvm_node, "v8.12.0"
set :nvm_map_bins, %w(node npm)

after "deploy:updated", "assets:compile"
# after "deploy:publishing", "puma:restart"
after "deploy:publishing", "sidekiq:restart"
