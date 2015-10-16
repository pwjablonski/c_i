class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def user_signed_in?
    session[:user_id] ? true : false
  end
  helper_method :user_signed_in?

  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      session[:user_id] = nil # or reset_session
    end
    
    
    helper_method :current_user

    def authorize
      render :new if !user_signed_in?
    end
end
