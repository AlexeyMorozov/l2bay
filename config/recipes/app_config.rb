namespace :app_config do
  desc "Setup application configuration file"
  task :setup, roles: :web do
    run "mkdir -p #{shared_path}/config"
    run "touch #{shared_path}/config/app_config.yml"
    run "chmod 600 #{shared_path}/config/app_config.yml"
  end
  after "deploy:setup", "app_config:setup"

  desc "Symlink app_config.yml file into the latest release"
  task :symlink do
    run "ln -nfs #{shared_path}/config/app_config.yml #{release_path}/config/app_config.yml"
  end
  after "deploy:finalize_update", "app_config:symlink"
end
