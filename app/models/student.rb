require 'csv'
require 'open-uri'
require 'httparty'


class Student < ActiveRecord::Base
    
    validates_uniqueness_of :profile_name
    
    belongs_to :user
    
    has_many :ca_data,  dependent: :destroy
    has_many :projects, dependent: :destroy
    has_many :enrollments, dependent: :destroy
    has_many :classrooms, through: :enrollments
    has_many :badges
    has_many :registrations
    has_many :events, through: :registrations
    
    belongs_to :school
    
    # require 'iconv'
    
    
    def verified_enrollments
        verified_enrollments = []
        self.enrollments.each do |enrollment|
            if enrollment.is_verified
                verified_enrollments << enrollment
            end
        end
        return verified_enrollments
    end


     def pending_response
        self.registrations.where(:status => "Pending Response")
    end 

    def pending_permission
        self.registrations.where(:status => "Attending: Pending Permission")
    end

    def completed
        self.registrations.where(:status => "Complete")
    end
    
    def self.upcoming_events
        all.where(start_time: (Time.now .. Time.now + 7.days))
    end


    
    
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
    
    def current_ca_score
       self.ca_data.last.total_points
    end
    
    

    def badges_array 
        response = HTTParty.get("http://api.credly.com/v1.1/members/#{self.credly_member_id}/badges?page=1&per_page=10&order_direction=ASC&access_token=dbd3cb19ee7c5fff3626b1be51dfef3c1c41fe73b624ff090e9d3b33c16db75530651552986b4897384c99f69a53bcea1fd2524daf8796d57bbab31869b5baa6",
                  :headers => { "X-Api-Key" => "03e428bf4d97a3ee22eecc2d61d520e6",
                                "X-Api-Secret" => "DcnuBwELqo7r5xZf5wwgY/KSiKy+qjAZ3vUmqurBOx6lO4pOIHg1idwIFJqOy9tn+lxa0S8zKpjZdFdIP7DSSbrp/0G1GRnaNaCAb+h/8E2Um5hLSjwzE4eEYIrAgGwMJUjDsJxhyCXh0Eg/yan3Z1+A2stHrMrGRC/lIh3PK5M="
                               }
        )
        badges_array=[]
        
        if response["data"] != nil
            response["data"].each do |badge|
              if badge["issuer_id"] == 2189689
                badges_array << badge
              end
            end
        else
            return badges_array
        end
        
        return badges_array
    end


    def earn_badge(badge_id)
      token = self.credly_authenticate
      response = HTTParty.post("https://api.credly.com/v1.1/member_badges?access_token=dbd3cb19ee7c5fff3626b1be51dfef3c1c41fe73b624ff090e9d3b33c16db75530651552986b4897384c99f69a53bcea1fd2524daf8796d57bbab31869b5baa6",
                  :headers => { "X-Api-Key" => "03e428bf4d97a3ee22eecc2d61d520e6",
                                "X-Api-Secret" => "DcnuBwELqo7r5xZf5wwgY/KSiKy+qjAZ3vUmqurBOx6lO4pOIHg1idwIFJqOy9tn+lxa0S8zKpjZdFdIP7DSSbrp/0G1GRnaNaCAb+h/8E2Um5hLSjwzE4eEYIrAgGwMJUjDsJxhyCXh0Eg/yan3Z1+A2stHrMrGRC/lIh3PK5M=",
                                
                  },
                  :query => { "member_id" => "#{self.credly_member_id}",
                              "badge_id" => badge_id,
                              "access_token" => token
                  }
        )
    end


    def credly_authenticate
        response = HTTParty.post("https://api.credly.com/v1.1/authenticate?access_token=dbd3cb19ee7c5fff3626b1be51dfef3c1c41fe73b624ff090e9d3b33c16db75530651552986b4897384c99f69a53bcea1fd2524daf8796d57bbab31869b5baa6",
                  :headers => { "X-Api-Key" => "03e428bf4d97a3ee22eecc2d61d520e6",
                                "X-Api-Secret" => "DcnuBwELqo7r5xZf5wwgY/KSiKy+qjAZ3vUmqurBOx6lO4pOIHg1idwIFJqOy9tn+lxa0S8zKpjZdFdIP7DSSbrp/0G1GRnaNaCAb+h/8E2Um5hLSjwzE4eEYIrAgGwMJUjDsJxhyCXh0Eg/yan3Z1+A2stHrMrGRC/lIh3PK5M="
                               },
                  basic_auth: { username: "pwjablonski@gmail.com", password: "56a79f018a2cc" }
        )
        return response["data"]["token"]
    end
    
    
    def get_credly_member_id
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
