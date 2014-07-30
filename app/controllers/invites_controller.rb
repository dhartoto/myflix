class InvitesController < ApplicationController

  before_action :require_user

  def create
    if fields_are_empty || invalid_email
      flash[:danger] = fields_are_empty ? "Fields can't be empty" : "Please enter a valid email"
      redirect_to invite_path
    else
      @inviter = current_user
      @invite = params[:invite].first
      MyflixMailer.invite_friend(@inviter, @invite).deliver
      redirect_to home_path
    end
  end

  private

  def fields_are_empty
    invite_params = params[:invite].first
    invite_params[:friend_name].blank? || invite_params[:friend_email].blank?
  end

  def invalid_email
    !(params[:invite].first[:friend_email] =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
  end
end
