class Classroom < ActiveRecord::Base
    belongs_to :user
    has_many :students
    has_many :teachers
    
    
    def num_students
        self.students.count
    end
    
    
end
