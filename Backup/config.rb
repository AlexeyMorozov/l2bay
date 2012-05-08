# encoding: utf-8

##
# Backup
# Generated Main Config Template
#
# For more information:
#
# View the Git repository at https://github.com/meskyanichi/backup
# View the Wiki/Documentation at https://github.com/meskyanichi/backup/wiki
# View the issue log at https://github.com/meskyanichi/backup/issues

##
# Global Configuration

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
# Load all models from the models directory (after the above global configuration blocks)
Dir[File.join(File.dirname(Config.config_file), "models", "*.rb")].each do |model|
  instance_eval(File.read(model))
end
