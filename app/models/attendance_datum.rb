class AttendanceDatum < ActiveRecord::Base
    
    belongs_to :registration
    belongs_to :enrollment
    belongs_to :attendance_list
    
    
end
