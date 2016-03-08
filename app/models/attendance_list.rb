class AttendanceList < ActiveRecord::Base
    belongs_to :classroom
    belongs_to :event
    has_many :attendance_data, dependent: :destroy
    
    accepts_nested_attributes_for :attendance_data
    
    
    
    
    def percent_present
        num_students = attendance_data.count
        num_present = 0.0
        
        self.attendance_data.each do |attendance_datum|
            if attendance_datum.present == true
                num_present += 1
            end
        end
        
        percent_present = (num_present/num_students) * 100.0
        
        return percent_present.round(2)
    end
    
    
    
end
