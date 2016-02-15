class Badge < ActiveRecord::Base
    belongs_to :students
    
    
    def issue_badge(credly_badge_id, badge_id, student, token)
        response = HTTParty.post("https://api.credly.com/v1.1/member_badges?access_token=dbd3cb19ee7c5fff3626b1be51dfef3c1c41fe73b624ff090e9d3b33c16db75530651552986b4897384c99f69a53bcea1fd2524daf8796d57bbab31869b5baa6",
                                 :headers => { "X-Api-Key" => "03e428bf4d97a3ee22eecc2d61d520e6",
                                 "X-Api-Secret" => "DcnuBwELqo7r5xZf5wwgY/KSiKy+qjAZ3vUmqurBOx6lO4pOIHg1idwIFJqOy9tn+lxa0S8zKpjZdFdIP7DSSbrp/0G1GRnaNaCAb+h/8E2Um5hLSjwzE4eEYIrAgGwMJUjDsJxhyCXh0Eg/yan3Z1+A2stHrMrGRC/lIh3PK5M=",
                                 
                                 },
                                 :query => { "member_id" => "#{student.credly_member_id}",
                                 "badge_id" => badge_id,
                                 "access_token" => token
            }
        )
    end
    
    
end
