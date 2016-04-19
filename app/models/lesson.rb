class Lesson < ActiveRecord::Base
    belongs_to :track 
    belongs_to :unit
    
end
