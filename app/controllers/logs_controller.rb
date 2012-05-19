class LogsController < ApplicationController
  before_filter :authenticate_user!, only: [:index]

  def index
    @logs = current_user.logs
  end
end
