class EnrollmentsController < ApplicationController
#    before_action :initialize_classroom, only: [:create]

    def create
        student = current_user.student
        classroom = Classroom.find(params[:classroom_id])
        
        @enrollment = classroom.add_student(student.id)
        respond_to do |format|
            if @enrollment.save
                format.html { redirect_to classroom_path(classroom),
                    notice: 'Student Enrolled!' }
                else
                redirect_to students_path
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
