namespace :backup do
  desc "Setup backup configs"
  task :setup, roles: :web do
    run "mkdir -p #{shared_path}/backup"
  end
  after "deploy:setup", "backup:setup"
end
