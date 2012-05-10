namespace :icons do
  desc "Upload icons"
  task :upload do
    host = find_servers.first.host
    run "mkdir -p #{shared_path}/icons"
    run_locally "rsync -rvz app/assets/icons/items #{user}@#{host}:#{shared_path}/icons/"
  end
  after "deploy:setup", "icons:upload"

  desc "Symlink icons"
  task :symlink do
    run "ln -nfs #{shared_path}/icons/items #{release_path}/app/assets/icons/items"
  end
  before "deploy:assets:precompile", "icons:symlink" unless precompile_without.include?('icons')

  desc "Prepare icon assets"
  task :assets do
    if precompile_without.include?('icons')
      run "cd #{shared_path}/assets && cat icons.yml >> manifest.yml"
    else
      run "cd #{shared_path}/assets && grep '^items\/' manifest.yml > icons.yml"
    end
  end
  after "deploy:assets:precompile", "icons:assets"
end
