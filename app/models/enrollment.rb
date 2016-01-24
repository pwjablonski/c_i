class Enrollment < ActiveRecord::Base
    
    belongs_to :classroom
    belongs_to :student
    has_many :attendance_data
    
    def percent_present
        days_present = 0.0
        total_days = 0.0
        
        self.attendance_data.each do |attendance_datum|
            if attendance_datum.present == true
                days_present += 1
            end
            total_days +=1
        end
        
        percent_present = (days_present/total_days) * 100.0
        
        return percent_present
        
    end
    
    
    def verify
        self.update_attribute(:is_verified, true)
        return true
    end
    
end
