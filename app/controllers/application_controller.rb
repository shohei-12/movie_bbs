class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  # Check user is logged in
  def check_logged_in
    redirect_to login_url unless logged_in?
  end
end
