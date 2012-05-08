# encoding: utf-8

APP_CONFIG = YAML.load(File.read(File.expand_path('../../config/app_config.yml', __FILE__)))

Backup::Database::PostgreSQL.defaults do |db|
  db.username           = "l2bay"
  db.password           = APP_CONFIG['db_password']
  db.host               = "localhost"
  db.port               = 5432
  db.additional_options = ["-xc", "-E=utf8"]
  # Optional: Use to set the location of this utility
  #   if it cannot be found by name in your $PATH
  # db.pg_dump_utility = "/opt/local/bin/pg_dump"
end

##
# Backup Generated: l2bay
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t l2bay [-c <path_to_configuration_file>]
#
Backup::Model.new(:l2bay, 'Description for l2bay') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250

  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    db.name = "l2bay_production"
  end

  database PostgreSQL do |db|
    db.name = "l2bay_game_production"
  end

  archive :l2bay do |archive|
    archive.add '/home/deployer/bin/uploads/'
    archive.add '/home/deployer/bin/*.py'
    archive.add '/home/deployer/list.pl'
    archive.add '/home/deployer/logs.cfg'
    archive.add '/etc/init.d/l2bay_receiver'
  end

  ##
  # Dropbox File Hosting Service [Storage]
  #
  # Access Type:
  #
  #  - :app_folder (Default)
  #  - :dropbox
  #
  # Note:
  #
  #  Initial backup must be performed manually to authorize
  #  this machine with your Dropbox account.
  #
  store_with Dropbox do |db|
    db.api_key     = APP_CONFIG['dropbox_key']
    db.api_secret  = APP_CONFIG['dropbox_secret']
    db.access_type = :app_folder
    db.path        = "/home/deployer/backups"
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the Wiki for other delivery options.
  # https://github.com/meskyanichi/backup/wiki/Notifiers
  #
  notify_by Mail do |mail|
    mail.on_success           = true
    mail.on_warning           = true
    mail.on_failure           = true

    mail.from                 = "L2bay <no-reply@l2bay.com>"
    mail.to                   = "admin@l2bay.com"
    mail.address              = "localhost"
    mail.port                 = 25
    mail.domain               = "l2bay.com"
    mail.authentication       = "plain"
    mail.enable_starttls_auto = false
  end

end
