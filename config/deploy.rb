require "bundler/capistrano"

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

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "service unicorn_#{application} #{command}"
    end
  end


  task :setup_configs, roles: :app do
    sudo "cp --remove-destination #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "cp --remove-destination #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    sudo "cp --remove-destination #{current_path}/config/sphinx_init.sh /etc/init.d/sphinx_#{application}"
    run "mkdir -p #{shared_path}/config"
    run "touch #{shared_path}/config/app_config.yml"
    run "chmod 640 #{shared_path}/config/app_config.yml"
  end
  after "deploy:setup", "deploy:setup_configs"

  task :setup_sphinx, roles: :app do
    run "mkdir -p #{shared_path}/sphinx"
  end
  after "deploy:setup", "deploy:setup_sphinx"

  task :upload_static, roles: :app do
    top.upload "static", "#{shared_path}/", recursive: true, via: :scp
  end
  after "deploy:setup", "deploy:upload_static"

  task :upload_icons, roles: :app do
    run_locally "tar -czf icons.tgz -C app/assets/images items"
    run "mkdir -p #{shared_path}/images"
    top.upload "icons.tgz", "#{shared_path}/images/icons.tgz"
    run "tar -xzf #{shared_path}/images/icons.tgz -C #{shared_path}/images"
    run "rm #{shared_path}/images/icons.tgz"
    run_locally "rm icons.tgz"
  end
  after "deploy:setup", "deploy:upload_icons"


  task :symlink_shared, roles: :app do
    run "ln -nfs #{shared_path}/config/app_config.yml #{release_path}/config/app_config.yml"
    run "ln -nfs #{shared_path}/sphinx #{release_path}/sphinx"
    run "cd #{release_path} && rake thebes:build RAILS_ENV=production"
    run "ln -nfs #{shared_path}/static #{release_path}/static"
    run "ln -nfs #{shared_path}/images/items #{release_path}/app/assets/images/items"
  end
  after "deploy:finalize_update", "deploy:symlink_shared"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"

  namespace :assets do
    task(:precompile) {} if ENV.has_key?('SKIP_PRECOMPILE')
  end
end
