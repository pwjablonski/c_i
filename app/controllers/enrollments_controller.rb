class EnrollmentsController < ApplicationController
#    before_action :initialize_classroom, only: [:create]

    def create
        @notice = ""
        @classroom = Classroom.find(params[:classroom_id])
        
        user_email_string = params[:student_email]
        user_email_list = user_email_string.split(",")
        
        user_email_list.each do |user_email|
            
          if User.find_by(email: user_email).try(:student?)
            @student = User.find_by(email: user_email).student
    
              @enrollment = @classroom.add_student(@student)
              
              if @enrollment == nil
                  @notice = @notice + "#{user_email} already enrolled  "
              else
                @enrollment.save
                @notice = @notice + "#{user_email} successfully enrolled  "
              end
          else
            @notice = @notice + "#{user_email} not found  "
          
          end
        end
        
        respond_to do |format|
                format.html {redirect_to classroom_path(@classroom),
                    notice: @notice }
        end
        
    end
    
    
    def destroy
        @enrollment = Enrollment.find(params[:id])
        @classroom = @enrollment.classroom
        @enrollment.destroy
        respond_to do |format|
            format.html { redirect_to @classroom, notice: 'School was successfully destroyed.' }
            format.json { head :no_content }
        end
    end


end
