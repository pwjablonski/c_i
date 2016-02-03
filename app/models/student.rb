require 'csv'
require 'open-uri'
require 'httparty'


class Student < ActiveRecord::Base
    
    validates_uniqueness_of :profile_name
    
    belongs_to :user
    
    has_many :ca_data
    has_many :projects
    has_many :enrollments
    has_many :classrooms, through: :enrollments
    
    belongs_to :school
    
    # require 'iconv'
    def update_ca_data
        ca_data_array =[]

        if self.codecademy_username == nil
            return    ca_data_array
        end
    
      uri = "https://www.codecademy.com/" + self.codecademy_username
    
      doc = Nokogiri::HTML(open(uri))
      
      doc.css("h3").each  do |element|
        ca_data_array << element.text
      end
      
      ca_data_array << doc.css("small")[4].text

      return ca_data_array

    end

    def badges_array
        badges_array=[]
        
        response = HTTParty.get("http://api.credly.com/v1.1/members/#{self.credly_member_id}/badges?page=1&per_page=10&order_direction=ASC&access_token=dbd3cb19ee7c5fff3626b1be51dfef3c1c41fe73b624ff090e9d3b33c16db75530651552986b4897384c99f69a53bcea1fd2524daf8796d57bbab31869b5baa6",
                  :headers => { "X-Api-Key" => "03e428bf4d97a3ee22eecc2d61d520e6",
                                "X-Api-Secret" => "DcnuBwELqo7r5xZf5wwgY/KSiKy+qjAZ3vUmqurBOx6lO4pOIHg1idwIFJqOy9tn+lxa0S8zKpjZdFdIP7DSSbrp/0G1GRnaNaCAb+h/8E2Um5hLSjwzE4eEYIrAgGwMJUjDsJxhyCXh0Eg/yan3Z1+A2stHrMrGRC/lIh3PK5M="
                               }
        )

        
        if response["data"] != nil
            badges_array = response["data"]
        else
            return badges_array
        end
        
    end
    
    
    def get_credly_member_id
        
#        
#        Credly.configuration do |config|
#            # These are the default values
#            config.base_endpoint = 'api.credly.com'
#            config.version       = 'v1.1'
#            config.access_token  = nil
#        end

#        client = Credly::Client.new(:username => 'pwjablonski@gmail.com', :password => '56a79f018a2cc')
#        client = Credly::Client.new(:access_token => 'dbd3cb19ee7c5fff3626b1be51dfef3c1c41fe73b624ff090e9d3b33c16db75530651552986b4897384c99f69a53bcea1fd2524daf8796d57bbab31869b5baa6')

        response = HTTParty.get("api.credly.com/v1.1/members?email=programs%40weare.ci&has_profile=0&verbose=0&page=1&per_page=10&order_direction=ASC&access_token=dbd3cb19ee7c5fff3626b1be51dfef3c1c41fe73b624ff090e9d3b33c16db75530651552986b4897384c99f69a53bcea1fd2524daf8796d57bbab31869b5baa6",
                                :headers => { "X-Api-Key" => "03e428bf4d97a3ee22eecc2d61d520e6",
                                "X-Api-Secret" => "DcnuBwELqo7r5xZf5wwgY/KSiKy+qjAZ3vUmqurBOx6lO4pOIHg1idwIFJqOy9tn+lxa0S8zKpjZdFdIP7DSSbrp/0G1GRnaNaCAb+h/8E2Um5hLSjwzE4eEYIrAgGwMJUjDsJxhyCXh0Eg/yan3Z1+A2stHrMrGRC/lIh3PK5M="
                                }
        )
        
        return response["data"]["id"]
    end



     def self.import(file, classroom_id = nil)
      CSV.foreach(file.path, headers: true) do |row|
      
      student_hash = row.to_hash # exclude the price field
      student_hash[:classroom_id] = classroom_id
      
      student = Student.where(id: student_hash["id"])

        if student.count == 1
          student.first.update_attributes(student_hash)
        else
          Student.create!(student_hash)
        end # end if !product.nil?
      end # end CSV.foreach
    end
  
end
