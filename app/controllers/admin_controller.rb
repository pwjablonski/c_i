class AdminController < ApplicationController
    before_action :admin_only
  
  def show
      @users = User.all
      @students = Student.all
      @teachers = Teacher.all
      
      @q = Classroom.ransack(params[:q])
      @classrooms = @q.result(distinct: true)
      
      
  end
  
  
  private
  
  def admin_only
      unless current_user.admin?
          redirect_to :back, :alert => "Access denied."
      end
  end

end
