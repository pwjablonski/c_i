class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  
  def after_sign_in_path_for(resource)
      if resource.try(:teacher?) && resource.teacher == nil
          new_teacher_path
      elsif resource.try(:teacher?)
          resource.teacher
      elsif resource.try(:student?) && resource.student == nil
          new_student_path
      elsif resource.try(:student?)
          resource.student
      elsif resource.try(:admin?)
          admin_show_path
      end
  end
 

  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit( :role, :email, :password, :password_confirmation) }
  end
  
  
end
