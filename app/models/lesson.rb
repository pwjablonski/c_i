class Lesson < ActiveRecord::Base
    belongs_to :track 
    belongs_to :unit
    acts_as_list scope: :unit
end
