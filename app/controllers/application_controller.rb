class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def current_server
    if @server
      @server
    elsif params[:server]
      @server = Server.find_by_name(params[:server].capitalize)
    elsif cookies[:server_id]
      @server = Server.find(cookies[:server_id])
    else
      @server = Server.first
    end
  end
  helper_method :current_server
end
