class GameDbMigration < ActiveRecord::Migration
  def connection
    if @connection.is_a? CommandRecorder
      @connection
    else
      GameDb.connection
    end
  end
end
