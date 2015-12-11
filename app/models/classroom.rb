class Classroom < ActiveRecord::Base
    belongs_to :teacher
    belongs_to :school
    
    has_many :enrollments, dependent: :destroy
    has_many :students, through: :enrollments
    has_many :notifications
    
    
    def add_student(student)
        student_id = student.id
        current_student = self.enrollments.find_by(student_id: student_id)
        if current_student
            current_student;
        else
            current_student = self.enrollments.build(student_id: student_id)
        end
        current_student
    end
    
    
    
#    def remove_student(student_id)
#        current_student = self.enrollments.find_by(student_id: student_id)
#        current_student
#    end
#    

    def num_students
        self.students.count
    end
    
    
end
