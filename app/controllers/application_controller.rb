class ApplicationController < ActionController::Base
  # Do not validate the Authenticity Token so that we can perform tests
  # using the ab tool
  skip_forgery_protection if: :testing_without_auth_token

  def current_user
    User.where(id: session[:user_id]).first
  end
  helper_method :current_user

  private

  def testing_without_auth_token
    Rails.env.development? && params[:test_no_auth_token]
  end
end
