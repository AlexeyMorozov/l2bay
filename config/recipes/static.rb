namespace :static do
  desc "Upload static files"
  task :upload do
    run_locally "rsync -rvz static #{user}@#{server}:#{shared_path}/"
  end
  after "deploy:setup", "static:upload"

  desc "Symlink static folder into the latest release"
  task :symlink do
    run "ln -nfs #{shared_path}/static #{release_path}/static"
  end
  after "deploy:finalize_update", "static:symlink"
end
