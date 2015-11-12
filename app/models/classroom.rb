class Classroom < ActiveRecord::Base
    belongs_to :teacher
    has_many :students
    
    
    def num_students
        self.students.count
    end
    
    
end
