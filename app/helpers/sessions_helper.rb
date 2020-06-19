module SessionsHelper
  # Log in with the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns true if the user is logged in
  def logged_in?
    !session[:user_id].nil?
  end

  # Return the logged in user
  def current_user
    if user_id = session[:user_id]
      User.find_by(id: user_id)
    end
  end

  # Returns true if the given user is logged in
  def current_user?(user)
    user && user == current_user
  end

  # Log out the current user
  def log_out
    session.delete(:user_id)
  end
end
