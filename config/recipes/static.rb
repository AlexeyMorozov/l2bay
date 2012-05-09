namespace :static do
  desc "Upload static files"
  task :upload do
    host = find_servers.first.host
    run_locally "rsync -rvz static #{user}@#{host}:#{shared_path}/"
  end
  after "deploy:setup", "static:upload"

  desc "Symlink static folder into the latest release"
  task :symlink do
    run "ln -nfs #{shared_path}/static #{release_path}/static"
  end
  after "deploy:finalize_update", "static:symlink"
end
