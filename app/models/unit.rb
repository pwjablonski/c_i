class Unit < ActiveRecord::Base
    belongs_to :track
    has_many :lessons
    accepts_nested_attributes_for :lessons
end
