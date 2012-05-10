namespace :sphinx do
  desc 'Generate sphinx config'
  task :config do
    sphinx_env = 'development'
    current_path = Rails.root
    sphinx_pid = Rails.root.join('tmp', 'pids', 'sphinx.pid')
    sphinx_log = Rails.root.join('log', 'searchd.log')
    sphinx_query_log = Rails.root.join('log', 'searchd.query.log')

    erb = ERB.new(File.read(Rails.root.join('config', 'recipes', 'templates', 'sphinx.conf.erb')))
    File.open(Rails.root.join('config', 'sphinx.conf'), 'w').write(erb.result(binding))
  end
end
