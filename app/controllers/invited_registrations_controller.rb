class InvitedRegistrationsController < ApplicationController

  def new
    if UserToken.find_by(token: params[:token])
      @user = User.new
      @friend_name = params[:friend_name]
      @friend_email = params[:friend_email]
      @token = params[:token]
      render 'users/new'
    else
     redirect_to register_path
    end
  end
end
