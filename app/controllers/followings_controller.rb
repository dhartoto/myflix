class FollowingsController < ApplicationController
  before_action :require_user

  def index
    @followings = current_user.followings
  end

  def create
    @following = current_user.followings.find_by(followee_id: params[:user_id])
    if @following
      flash[:error] = "You are already following #{ @following.user.full_name }"
    else
      @following = Following.create(user: current_user, followee_id: params[:user_id] )
      flash[:success] = "You are now following #{ @following.user.full_name }"
    end
    redirect_to people_path
  end
end
