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
    if (user_id = session[:user_id])
      User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies[:remember_token])
        log_in user
        user
      end
    end
  end

  # Returns true if the given user is logged in
  def current_user?(user)
    user && user == current_user
  end

  # Log out the current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
  end

  # Make a user's session persistent
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Break a persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
