set_default(:sphinx_user) { user }
set_default(:sphinx_pid) { "#{current_path}/tmp/pids/sphinx.pid" }
set_default(:sphinx_config) { "#{shared_path}/config/sphinx.conf" }
set_default(:sphinx_log) { "#{shared_path}/log/searchd.log" }
set_default(:sphinx_query_log) { "#{shared_path}/log/searchd.query.log" }

namespace :sphinx do
  desc "Setup Sphinx initializer and app configuration"
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/db/sphinx"
    run "mkdir -p #{shared_path}/config"
    template "sphinx.conf.erb", sphinx_config
    template "sphinx_init.erb", "/tmp/sphinx_init"
    run "chmod +x /tmp/sphinx_init"
    run "#{sudo} mv /tmp/sphinx_init /etc/init.d/sphinx_#{application}"
    run "#{sudo} update-rc.d -f sphinx_#{application} defaults"
  end
  after "deploy:setup", "sphinx:setup"

  desc "Symlink sphinx folder into the latest release"
  task :symlink do
    run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
  end
  after "deploy:finalize_update", "sphinx:symlink"

  %w[start stop restart reindex].each do |command|
    desc "#{command} sphinx"
    task command, roles: :app do
      run "service sphinx_#{application} #{command}"
    end
    after "deploy:#{command}", "sphinx:#{command}"
  end
end
