class Event < ActiveRecord::Base
    acts_as_messageable
    
    has_many :attendance_lists
    has_many :attendance_data, through: :attendance_lists
    
    has_many :registrations
    has_many :students, through: :registrations
    
    
    
    
    def add_student(student, status)
        student_id = student.id
        registration = self.registrations.find_by(student_id: student_id)
        if registration
            return nil;
        else
        registration = self.registrations.build(student_id: student_id, status: status)
        registration.save
        AttendanceDatum.create(registration_id: registration.id, present: false)
        end
        registration
    end
    
    def find_registration(student)
        registration = self.registrations.find_by(student: student.id)
        return registration
    end
    
    
    
#    
#    def eventbrite_api
#        
#        eb_auth_tokens = { app_key: 'UXZIZCKXNCM54QYE5AYWCKTWPPVFTTSL4SCHLCKCQPP4RQYUSY',
#            user_key: 'RQNDN6PAOY6OQK3TFDJQ'}
#        
#        auth_token = "RQNDN6PAOY6OQK3TFDJQ"
#        response = HTTParty.get("https://www.eventbriteapi.com/v3/users/me/owned_events/?token=#{auth_token}")
#        auth_token = "RQNDN6PAOY6OQK3TFDJQ"
#        url = "&event.name.html=Awesome%20Event&event.listed=true&event.start.utc=#{self.start_time.iso8601}&event.end.utc=#{self.end_time.iso8601}&event.start.timezone=America%2FNew_York&event.end.timezone=America%2FNew_York&event.currency=USD"
#        response = HTTParty.post("https://www.eventbriteapi.com/v3/events/?token=#{auth_token}" + url)
#        
#    end
#    
#    
#    def create_eventbrite_event(event_params)
#        
#        auth_token = "RQNDN6PAOY6OQK3TFDJQ"
#        url = "&event.name.html=#{event_params[:name]}&event.listed=true&event.start.utc=#{self.start_time.iso8601}&event.end.utc=#{self.end_time.iso8601}&event.start.timezone=America%2FNew_York&event.end.timezone=America%2FNew_York&event.currency=USD&event.description.html=#{self.description}"
#        response = HTTParty.post("https://www.eventbriteapi.com/v3/events/?token=#{auth_token}" + url)
#        
#        self.update_attribute(:eb_event_id, response.parsed_response["id"] )
#        
#        return response.parsed_response
#    end
#    
#    def show_eventbrite_event
#        
#        auth_token = "RQNDN6PAOY6OQK3TFDJQ"
#        
#        response = HTTParty.get("https://www.eventbriteapi.com/v3/events/#{self.eb_event_id}/?token=#{auth_token}" )
#
#        return response.parsed_response
#    end
#    
#    
#    
#    def create_eventbrite_tickets
#        auth_token = "RQNDN6PAOY6OQK3TFDJQ"
#        url = "&ticket_class.name=Student&ticket_class.quantity_total=#{self.num_tickets}&ticket_class.free=true&ticket_class.maximum_quantity=1"
#        response = HTTParty.post("https://www.eventbriteapi.com/v3/events/#{self.eb_event_id}/ticket_classes/?token=#{auth_token}" + url)
#    end
#    
#    
#    
#    
#    def update_eventbrite_event(event_params)
#        auth_token = "RQNDN6PAOY6OQK3TFDJQ"
#        url = "&event.name.html=#{event_params[:name]}&event.listed=true&event.start.utc=#{event_params[:start_time]}&event.end.utc=#{event_params[:end_time]}&event.start.timezone=America%2FNew_York&event.end.timezone=America%2FNew_York&event.currency=USD&event.description.html=#{event_params[:description]}"
#        
#        response = HTTParty.post("https://www.eventbriteapi.com/v3/events/#{self.eb_event_id}/?token=#{auth_token}" + url)
#    end
#    
#    def destroy_eventbrite_event
#        auth_token = "RQNDN6PAOY6OQK3TFDJQ"
#        response = HTTParty.delete("https://www.eventbriteapi.com/v3/events/#{self.eb_event_id}/?token=#{auth_token}")
#    end
#    
#    def publish_eventbrite_event
#        auth_token = "RQNDN6PAOY6OQK3TFDJQ"
#        response = HTTParty.post("https://www.eventbriteapi.com/v3/events/#{self.eb_event_id}/publish/?token=#{auth_token}")
#    end
#   
#   def unpublish_eventbrite_event
#       auth_token = "RQNDN6PAOY6OQK3TFDJQ"
#       response = HTTParty.post("https://www.eventbriteapi.com/v3/events/#{self.eb_event_id}/unpublish/?token=#{auth_token}")
#       
#    end
#   
#   def orders
#       auth_token = "RQNDN6PAOY6OQK3TFDJQ"
#       response = HTTParty.get("https://www.eventbriteapi.com/v3/events/#{self.eb_event_id}/orders/?token=#{auth_token}")
#       return response.parsed_response
#   end
#   
#   def attendees
#       auth_token = "RQNDN6PAOY6OQK3TFDJQ"
#       response = HTTParty.get("https://www.eventbriteapi.com/v3/events/#{self.eb_event_id}/attendees/?token=#{auth_token}")
#       return response.parsed_response
#   end
#   
#   def create_eventbrite_registrations
#       
#       attendees = self.attendees["attendees"]
#       
#       attendees.each do |attendee|
#            @event_registration = self.event_registrations.find_by(eb_attendee_id: attendee["id"])
#               
#            if @event_registration
#                puts "event exist already"
#                next
#            else
#                if User.find_by(email: attendee["profile"]["email"]).try(:student?)
#                    student = User.find_by(email: attendee["profile"]["email"]).student
#                    @event_registration = self.event_registrations.create(student_id: student.id, eb_event_id: self.eb_event_id, eb_attendee_id: attendee["id"])
#                     puts "event created"
#                else
#                     puts "no user exist"
#                    next
#                end
#            end
#       end
#   end

    
end
