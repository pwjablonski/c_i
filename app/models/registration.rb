class Registration < ActiveRecord::Base
    
    belongs_to :event
    belongs_to :student
    has_one :attendance_datum
    
    
    def get_signature_status
        if self.signature_request_id
            signature_request = HelloSign.get_signature_request :signature_request_id => self.signature_request_id
             signature_request.signatures[0].status_code
        else
            return "Not Sent"
        end
    end
    
    
    def get_signature_status_url
        if self.signature_request_id
            signature_request = HelloSign.get_signature_request :signature_request_id => self.signature_request_id
            signature_request.details_url
        else
            return ""
        end
    end
    
    
end
