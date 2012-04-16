class UserIdsController < ApplicationController
  def index
    if params[:email]
      user = User.find_by_email(params[:email])
      render text: user ? user.id : 0
    else
      render nothing: true
    end
  end
end
