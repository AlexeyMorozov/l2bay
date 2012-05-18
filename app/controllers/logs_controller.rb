class LogsController < ApplicationController
  def index
    @logs = current_user.logs
  end
end
