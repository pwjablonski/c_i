class Users::RegistrationsController < Devise::RegistrationsController
 before_filter :configure_sign_up_params, only: [:create]
 before_filter :configure_account_update_params, only: [:update]

#  # GET /resource/sign_up
#   def new
#     super
#   end
#
  # POST /resource
   def create
       puts "before change role #{sign_up_params}"
       new_sign_up_params = sign_up_params
       new_sign_up_params[:role] = 0
       
       
        puts "change role #{sign_up_params}"
       build_resource(new_sign_up_params)
       puts "sign up params after build #{sign_up_params}"
       
       resource.save
       
#       if resource.try(:student?)
#           Student.create(:user_id => resource.id)
#        elsif resource.try(:teacher?)
#            Teacher.create(:user_id => resource.id)
#        elsif current_user.try(:admin?)
#            Admin.create(:user_id => resource.id)
#       end

      
       
       yield resource if block_given?
       if resource.persisted?
           if resource.active_for_authentication?
               set_flash_message :notice, :signed_up if is_flashing_format?
               sign_up(resource_name, resource)
               respond_with resource, location: after_sign_up_path_for(resource)
               else
               set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
               expire_data_after_sign_in!
               respond_with resource, location: after_inactive_sign_up_path_for(resource)
           end
           else
           clean_up_passwords resource
           set_minimum_password_length
           respond_with resource
       end


   end
#
#  # GET /resource/edit
#   def edit
#     super
#   end
#
#  # PUT /resource
#   def update
#     super
#   end
#
  # DELETE /resource
   def destroy
     
     if current_user.student? || current_user.admin?
        current_user.student.destroy
     elsif current_user.teacher? || current_user.admin?
        current_user.teacher.destroy
     end
        
#    if user.student?
#        student = Student.find(user.student.id)
#        student.destroy
#    elsif user.teacher?
#        user.teacher.destroy
#    end

#        user.destroy
        super
   end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
       devise_parameter_sanitizer.for(:sign_up) { |u| u.permit( :role, :email, :password, :password_confirmation) }
   end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

#   The path used after sign up.
   def after_sign_up_path_for(resource)
    if resource.try(:teacher?)
         teacher_path
    elsif resource.try(:student?)
        resource.student
    elsif resource.try(:admin?)
        users_path
    end
   end

  # The path used after sign up for inactive accounts.
#   def after_inactive_sign_up_path_for(resource)
#     new_teacher_path
#   end
end
