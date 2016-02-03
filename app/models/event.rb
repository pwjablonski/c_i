class Event < ActiveRecord::Base
    
    def eventbrite_api
        
        eb_auth_tokens = { app_key: 'UXZIZCKXNCM54QYE5AYWCKTWPPVFTTSL4SCHLCKCQPP4RQYUSY',
            user_key: 'RQNDN6PAOY6OQK3TFDJQ'}
        
        auth_token = "RQNDN6PAOY6OQK3TFDJQ"
        response = HTTParty.get("https://www.eventbriteapi.com/v3/users/me/owned_events/?token=#{auth_token}")
        auth_token = "RQNDN6PAOY6OQK3TFDJQ"
        url = "&event.name.html=Awesome%20Event&event.listed=true&event.start.utc=2010-01-31T13:00:00Z&event.end.utc=2010-01-31T14:00:00Z&event.start.timezone=America%2FNew_York&event.end.timezone=America%2FNew_York&event.currency=USD"
        response = HTTParty.post("https://www.eventbriteapi.com/v3/events/?token=#{auth_token}" + url)
        
    end
    
    
    def create_eventbrite_event(event_params)
        
        auth_token = "RQNDN6PAOY6OQK3TFDJQ"
        url = "&event.name.html=#{event_params[:name]}&event.listed=true&event.start.utc=2010-01-31T13:00:00Z&event.end.utc=2010-01-31T14:00:00Z&event.start.timezone=America%2FNew_York&event.end.timezone=America%2FNew_York&event.currency=USD"
        response = HTTParty.post("https://www.eventbriteapi.com/v3/events/?token=#{auth_token}" + url)
        
        self.update_attribute(:eventbrite_id, response.parsed_response["id"] )
        
        return response.parsed_response
    end
    
    def show_eventbrite_event
        eventbrite_id = self.eventbrite_id

        auth_token = "RQNDN6PAOY6OQK3TFDJQ"
        url = "&ticket_class.name=Student&ticket_class.quantity_total=10&ticket_class.free=true"
        response = HTTParty.get("https://www.eventbriteapi.com/v3/events/#{eventbrite_id}/?token=#{auth_token}" + url)

        return response.parsed_response
    end
    
    
    
    
    
    def create_eventbrite_tickets(num_tickets)
        
        auth_token = "RQNDN6PAOY6OQK3TFDJQ"
        url = "&ticket_class.name=Student&ticket_class.quantity_total=#{num_tickets}&ticket_class.free=true"
        response = HTTParty.post("https://www.eventbriteapi.com/v3/events/#{self.eventbrite_id}/ticket_classes/?token=#{auth_token}" + url)
    end
    
    
    
    
    def update_eventbrite_event(event_params)
        auth_token = "RQNDN6PAOY6OQK3TFDJQ"
        url = "&event.name.html=A#{event_params[:name]}&event.listed=true&event.start.utc=2010-01-31T13:00:00Z&event.end.utc=2010-01-31T14:00:00Z&event.start.timezone=America%2FNew_York&event.end.timezone=America%2FNew_York&event.currency=USD"
        
        response = HTTParty.post("https://www.eventbriteapi.com/v3/events/#{self.eventbrite_id}/?token=#{auth_token}" + url)
    end
    
    def destroy_eventbrite_event
        
    end
    
    def publish_eventbrite_event
        auth_token = "RQNDN6PAOY6OQK3TFDJQ"
        response = HTTParty.post("https://www.eventbriteapi.com/v3/events/#{self.eventbrite_id}/publish/?token=#{auth_token}")
    end
    
    
    
    
end
