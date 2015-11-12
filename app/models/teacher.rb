class Teacher < ActiveRecord::Base
    
    belongs_to :user
    
    
    has_many :classrooms
    has_many :students, through: :classrooms
    
end
