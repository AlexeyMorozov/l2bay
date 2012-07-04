# encoding: utf-8

Backup::Model.new(:l2bay, 'Description for l2bay') do
  split_into_chunks_of 50

  database PostgreSQL do |db|
    db.name = "l2bay_production"
  end

  database PostgreSQL do |db|
    db.name = "l2bay_game_production"
  end

  archive :l2bay do |archive|
    archive.add '/home/deployer/bin/uploads/'
    archive.add '/home/deployer/bin/daemon.py'
    archive.add '/home/deployer/bin/parser.py'
    archive.add '/home/deployer/bin/receiver.py'
    archive.add '/home/deployer/list.pl'
    archive.add '/home/deployer/logs.cfg'
    archive.add '/etc/init.d/l2bay_receiver'
  end

  store_with Dropbox do |db|
    db.api_key     = APP_CONFIG['dropbox_key']
    db.api_secret  = APP_CONFIG['dropbox_secret']
    db.access_type = :app_folder
    db.path        = "/backups"
    db.keep        = 30
  end

  compress_with Gzip

  notify_by Mail do |mail|
    mail.on_success           = false
    mail.on_warning           = true
    mail.on_failure           = true

    mail.from                 = "L2bay <no-reply@l2bay.com>"
    mail.to                   = "admin@l2bay.com"
    mail.address              = "localhost"
    mail.port                 = 25
    mail.domain               = "l2bay.com"
    mail.enable_starttls_auto = false
  end
end
