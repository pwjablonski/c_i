class Classroom < ActiveRecord::Base
    belongs_to :teacher
    has_many :students
    belongs_to :school
    
    
    def num_students
        self.students.count
    end
    
    
end
