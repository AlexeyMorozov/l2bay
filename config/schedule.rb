set :output, "#{path}/log/cron.log"

every 6.hours do
  command <<-CMD
    cd #{path} && \
    bundle exec backup perform -t l2bay -c #{path}/backup/config.rb \
      -l #{path}/log/ --tmp-path #{path}/tmp/backup/ --root-path ../shared/backup
  CMD
end
