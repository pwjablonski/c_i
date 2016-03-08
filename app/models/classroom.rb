class Classroom < ActiveRecord::Base
    belongs_to :teacher
    belongs_to :school
    
    has_many :enrollments, dependent: :destroy
    has_many :students, through: :enrollments
    has_many :notifications
    has_many :attendance_lists
    has_many :attendance_data, through: :attendance_lists
    
    acts_as_messageable
    
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

def percent_present
    total_percent_present = 0.0
   
    
    self.verified_enrollments.each do |enrollment|
        total_percent_present += enrollment.percent_present
    end
    
    class_percent_present = (total_percent_present/self.verified_enrollments.count)
    
    return class_percent_present.round(2)
    
end

def calculate_ca_points
    class_total_ca_score = 0.0
    
    self.verified_enrollments.each do |enrollment|
        class_total_ca_score = enrollment.student.current_ca_score
    end
    self.update_attribute(:ca_points, class_total_ca_score)
    class_total_ca_score
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
