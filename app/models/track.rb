class Track < ActiveRecord::Base
    has_many :units
    has_many :lessons
    has_many :students
    
    accepts_nested_attributes_for :units
end
