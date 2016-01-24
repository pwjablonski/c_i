class Classroom < ActiveRecord::Base
    belongs_to :teacher
    belongs_to :school
    
    has_many :enrollments, dependent: :destroy
    has_many :students, through: :enrollments
    has_many :notifications
    has_many :attendance_lists
    has_many :attendance_data, through: :attendance_lists
    
    
    def add_student(student)
        student_id = student.id
        current_student = self.enrollments.find_by(student_id: student_id)
        if current_student
            return nil;
        else
            current_student = self.enrollments.build(student_id: student_id)
        end
        current_student
    end
    
    def verified_enrollments
        verified_enrollments = []
        self.enrollments.each do |enrollment|
            if enrollment.is_verified
                verified_enrollments << enrollment
            end
        end
        return verified_enrollments
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
