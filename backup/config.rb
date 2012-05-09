# encoding: utf-8

APP_CONFIG = YAML.load(File.read(File.expand_path('../../config/app_config.yml', __FILE__)))

Backup::Database::PostgreSQL.defaults do |db|
  db.username           = "l2bay"
  db.password           = APP_CONFIG['db_password']
  db.host               = "localhost"
  db.port               = 5432
  db.additional_options = ["-xc", "-E=utf8"]
end

Dir[File.join(File.dirname(Config.config_file), "models", "*.rb")].each do |model|
  instance_eval(File.read(model))
end
