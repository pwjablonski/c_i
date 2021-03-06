class Project < ActiveRecord::Base
    belongs_to :student
    acts_as_messageable
    
    def fetch_devpost_data
        devpost_data_array =[]
        
        if self.devpost_url == ""
            return  devpost_data_array
        end
        
        uri = self.devpost_url
        
        
        doc = Nokogiri::HTML(open(uri))
        
        doc.css("#app-details-left h2, #app-details-left p").each  do |element|
            devpost_data_array << element.text
        end
        
        return devpost_data_array
        
    end


    def self.recent_projects
        all.where(created_at: (Time.now - 7.days .. Time.now))
    end
    
end
