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


#    def credly_register
#        
#        response = HTTParty.get(
#                                 "http://api.credly.com/v1.1/me?access_token=8d64a7affcef10ab3428ef26579a1afcf59b59a06301e9ab75a60d64bc959c428889fabf59e531af808051b3dfd812772f974b5d31a162b7e554744c40bd178f",
#                                 
#                                 :headers => {   "X-Api-Key" => "03e428bf4d97a3ee22eecc2d61d520e6",
#                                 "X-Api-Secret" => "DcnuBwELqo7r5xZf5wwgY/KSiKy+qjAZ3vUmqurBOx6lO4pOIHg1idwIFJqOy9tn+lxa0S8zKpjZdFdIP7DSSbrp/0G1GRnaNaCAb+h/8E2Um5hLSjwzE4eEYIrAgGwMJUjDsJxhyCXh0Eg/yan3Z1+A2stHrMrGRC/lIh3PK5M="
#                                 },
#                                 
#                                 )
#
#
#
#
#
#
#       
#        response = HTTParty.post(
#                                 "http://api.credly.com/v1.1/authenticate?access_token=7886a0c6fd8d9ae9fc02c9e1252eac1b0e1922e47171564e749513eb2d16ab34dad44300828849963d7549a365cb49e88ad4aa2cc1d84aae069a53ef6880d35e",
#                                
#                                :headers => {   "X-Api-Key" => "03e428bf4d97a3ee22eecc2d61d520e6",
#                                                "X-Api-Secret" => "DcnuBwELqo7r5xZf5wwgY/KSiKy+qjAZ3vUmqurBOx6lO4pOIHg1idwIFJqOy9tn+lxa0S8zKpjZdFdIP7DSSbrp/0G1GRnaNaCAb+h/8E2Um5hLSjwzE4eEYIrAgGwMJUjDsJxhyCXh0Eg/yan3Z1+A2stHrMrGRC/lIh3PK5M="
#                                },
#                                 
#                                :basic_auth => {
#                                                :email => "pwjablonski@gmail.com",
#                                                :password => "Chowndir0"
#                                 }
#                                )
#                                
#                                curl \
#                                -H "X-Api-Key: 03e428bf4d97a3ee22eecc2d61d520e6" \
#                                -H "X-Api-Secret: DcnuBwELqo7r5xZf5wwgY/KSiKy+qjAZ3vUmqurBOx6lO4pOIHg1idwIFJqOy9tn+lxa0S8zKpjZdFdIP7DSSbrp/0G1GRnaNaCAb+h/8E2Um5hLSjwzE4eEYIrAgGwMJUjDsJxhyCXh0Eg/yan3Z1+A2stHrMrGRC/lIh3PK5M=" \
#                                --user "pwjablonski@gmail.com:Chowndir0" \
#                                --data "" \
#                                https://api.credly.com/v1.1/authenticate
#
#
#    end


    def badges_array
        response = HTTParty.get("http://api.credly.com/v1.1/members/#{self.credly_member_id}/badges?page=1&per_page=10&order_direction=ASC&access_token=dbd3cb19ee7c5fff3626b1be51dfef3c1c41fe73b624ff090e9d3b33c16db75530651552986b4897384c99f69a53bcea1fd2524daf8796d57bbab31869b5baa6",
                  :headers => { "X-Api-Key" => "03e428bf4d97a3ee22eecc2d61d520e6",
                                "X-Api-Secret" => "DcnuBwELqo7r5xZf5wwgY/KSiKy+qjAZ3vUmqurBOx6lO4pOIHg1idwIFJqOy9tn+lxa0S8zKpjZdFdIP7DSSbrp/0G1GRnaNaCAb+h/8E2Um5hLSjwzE4eEYIrAgGwMJUjDsJxhyCXh0Eg/yan3Z1+A2stHrMrGRC/lIh3PK5M="
                               }
        )
        
        
        badges_array = response["data"]
        
        return badges_array
        
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
