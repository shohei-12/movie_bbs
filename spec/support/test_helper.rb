module TestHelper
  # Return true if the test user is logged in
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Log in as a test user
  def log_in_as(user)
    page.set_rack_session(user_id: user.id)
  end
end
