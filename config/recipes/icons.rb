namespace :icons do
  desc "Upload icons"
  task :upload do
    host = find_servers.first.host
    run "mkdir -p #{shared_path}/images"
    run_locally "rsync -rvz app/assets/images/items #{user}@#{host}:#{shared_path}/images/"
  end
  after "deploy:setup", "icons:upload"

  desc "Symlink icons"
  task :symlink do
    run "ln -nfs #{shared_path}/images/items #{release_path}/app/assets/images/items"
  end
  before "deploy:assets:precompile", "icons:symlink" unless precompile_without.include?('icons')

  desc "Append already compiled icon assets"
  task :append_assets do
    run "cd #{shared_path}/assets && cat item_icons.yml >> manifest.yml"
  end
  after "deploy:assets:precompile", "icons:append_assets" if precompile_without.include?('icons')
end
