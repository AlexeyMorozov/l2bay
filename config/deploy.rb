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
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    sudo "ln -nfs #{current_path}/config/sphinx_init.sh /etc/init.d/sphinx_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/app_config.yml"), "#{shared_path}/config/app_config.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :setup_sphinx, roles: :app do
    run "mkdir -p #{shared_path}/sphinx"
  end
  after "deploy:setup", "deploy:setup_sphinx"

  task :upload_static, roles: :app do
    run "mkdir -p #{shared_path}/static"
    upload "static/items.yml", "#{shared_path}/static/"
  end
  after "deploy:setup", "deploy:upload_static"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/app_config.yml #{release_path}/config/app_config.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  task :symlink_sphinx, roles: :app do
    run "ln -nfs #{shared_path}/sphinx #{release_path}/sphinx"
    run "cd #{release_path} && rake thebes:build RAILS_ENV=production"
  end
  after "deploy:finalize_update", "deploy:symlink_sphinx"

  task :symlink_item_icons, roles: :app do
    run "ln -nfs #{shared_path}/images/items #{release_path}/app/assets/images/items"
  end
  after "deploy:finalize_update", "deploy:symlink_item_icons"

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
    task :precompile, :roles => :web, :except => { :no_release => true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        puts "Precompiling because there were changes"
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end
end
