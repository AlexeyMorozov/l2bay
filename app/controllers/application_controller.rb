class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_server
    @server ||= params[:server] ? Server.find_by_name(params[:server].capitalize)
      : cookies[:server_id] ? Server.find(cookies[:server_id]) : Server.first
  end
  helper_method :current_server
end
