class UserAccess

  attr_reader :approved, :error_message

  def initialize(user)
    @user = user
  end

  def sign_in(password)
    if user && user.authenticate(password)
      if user.active?
        @approved = true
        self
      else
        @error_message = "Your account has been suspended."
        @approved = false
        self
      end
    else
      @error_message = "Incorrect email or password. Please try again."
      @approved = false
      self
    end
  end
end
