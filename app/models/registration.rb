class Registration < ActiveRecord::Base
    
    belongs_to :event
    belongs_to :student
    has_one :attendance_datum
    
    
    def get_signature_status(adobe_token)
        if self.signature_request_id
            signature_request = HTTParty.get("https://api.na1.echosign.com:443/api/rest/v5/agreements/#{self.signature_request_id}",
                                             :headers => {
                                             "Access-Token" => adobe_token,
                                             "x-api-user" => "email:peter@campinteractive.org"
                                             
                                             },
                                             )
        signature_request.parsed_response

        else
            return "Not Sent"
        end
    end
    
    
#    def get_signature_status_url
#        if self.signature_request_id
#            signature_request = HelloSign.get_signature_request :signature_request_id => self.signature_request_id
#            signature_request.details_url
#        else
#            return ""
#        end
#    end

    
end
