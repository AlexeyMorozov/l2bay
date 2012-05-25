class SoftwareController < ApplicationController
  before_filter :authenticate_user!, only: [:index]
  def index
  end

  def download
    if user_signed_in?
      send_file Rails.root.join("static/updater.exe"), filename: "#{current_user.email}@.exe"
    else
      redirect_to action: 'index'
    end
  end
end
