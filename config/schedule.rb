set :output, "#{path}/log/cron.log"

every 6.hours do
  command "cd #{path} && bundle exec backup perform -t l2bay -c config/backup/config.rb"
end
