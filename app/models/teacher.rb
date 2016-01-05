class Teacher < ActiveRecord::Base
    
    belongs_to :user
    belongs_to :school
    
    has_many :classrooms
    has_many :enrollments, through: :classrooms
    has_many :students, through: :enrollments
    
end
