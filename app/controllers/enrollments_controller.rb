class EnrollmentsController < ApplicationController
#    before_action :initialize_classroom, only: [:create]

    def create
        
            @student = User.find_by(email: params[:student_email]).student
#           @student = User.find_by(email: params[:enrollment][:student_id]).student
            @classroom = Classroom.find(params[:classroom_id])
            @enrollment = nil
            if @student != nil
             @enrollment = @classroom.add_student(@student)
            end
 
        respond_to do |format|
            if @enrollment.save
                format.html { redirect_to classroom_path(@classroom),
                    notice: 'Student Enrolled!' }
            else
                format.html { redirect_to classroom_path(@classroom),
                    notice: 'Student Was Not Enrolled!' }

            end
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
