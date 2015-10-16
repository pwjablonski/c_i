class Classroom < ActiveRecord::Base
    belongs_to :user
    has_many :students
    
    
    def num_students
        self.students.count
    end
    
    
end
