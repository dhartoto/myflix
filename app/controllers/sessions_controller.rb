class SessionsController < ApplicationController

  def new
    redirect_to home_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:email])
    access = UserAccess.new(user).sign_in(params[:password])
    if access.approved
      session[:username] = user.username
      flash[:success] = "Welcome #{ user.username }"
      redirect_to home_path
    else
      flash[:danger] = access.error_message
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:username] = nil
    flash[:success] = "You have signed out."
    redirect_to :root
  end

end
