set :output, "#{path}/log/cron.log"

every 6.hours do
  command "backup perform -t l2bay -c #{path}/Backup/config.rb -l #{path}/log/backup.log"
end
