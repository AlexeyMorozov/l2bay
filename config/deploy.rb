require "bundler/capistrano"

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

load 'config/recipes/base'
load 'config/recipes/check'
load 'config/recipes/app_config'
load 'config/recipes/assets'
load 'config/recipes/backup'
load 'config/recipes/icons'
load 'config/recipes/nginx'
load 'config/recipes/sphinx'
load 'config/recipes/static'
load 'config/recipes/unicorn'

server "l2bay.com", :web, :app, :db, primary: true

set :application, "l2bay"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@bitbucket.org:rekky/l2bay.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases
