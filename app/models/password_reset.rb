class PasswordReset < ActiveRecord::Base
  belongs_to :user

  def to_param
    token
  end
end
