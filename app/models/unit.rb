class Unit < ActiveRecord::Base
    belongs_to :track
    has_many :lessons
    has_many :quizes
    accepts_nested_attributes_for :lessons
end
