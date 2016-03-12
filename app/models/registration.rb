class Registration < ActiveRecord::Base
    
    belongs_to :event
    belongs_to :student
    has_one :attendance_datum
    
    
    def get_signature_status
        if self.signature_request_id
            signature_request = HTTParty.get("https://api.na1.echosign.com:443/api/rest/v5/agreements/3AAABLblqZhBpq4KklZp7i-wN3sivwzpJVFdUJq5Cw-TM7xTr4sJ-crJ1sMT0-8btft63Zi0lDEHB7ubieayZqRhLg5LdPai5",
                                             :headers => {
                                             "Access-Token" => "session[:token]",
                                             "x-api-user" => "email:peter@campinteractive.org"
                                             
                                             },
                                             )
        signature_request.parsed_response

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
