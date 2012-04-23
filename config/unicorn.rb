root = "/home/deployer/apps/l2bay/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.l2bay.sock"
worker_processes 2
timeout 30
