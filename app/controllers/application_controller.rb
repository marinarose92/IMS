class ApplicationController < ActionController::Base
protect_from_forgery with: :exception
helper_method :current_user
# before_action :require_login

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

private

  def logged_in?
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

#   def require_login
#     unless logged_in?
#       flash[:error] = "You must be logged in to access this section."
#       redirect_to login_path
#     end
#   end
end