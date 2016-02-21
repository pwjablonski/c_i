class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, :except => :show
 

  def index
      @q = User.ransack(params[:q])
      @users = @q.result(distinct: true)
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
#    if user.student?
#        student = Student.find(user.student.id)
#        student.destroy
#    elsif user.teacher?
#        user.teacher.destroy
#    end

    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end
  
  def toggle_approved
    @user = User.find(params[:id])
      
    if @user.approved == true
    @user.update_attribute(:approved, false)
    elsif 
    @user.update_attribute(:approved, true)
    end
    
    redirect_to users_path
  end



  private

  def admin_only
    unless current_user.admin?
      redirect_to root_path, :alert => "Access denied."
    end
  end

  def secure_params
    params.require(:user).permit(:role)
  end

  
end
