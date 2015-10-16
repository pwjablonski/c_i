class User < ActiveRecord::Base
    has_many :students, through: :classrooms
    has_many :classrooms
    
    
    
    
    validates_uniqueness_of :name
    validates_presence_of :name
    
    validates_uniqueness_of :email
    validates_presence_of :email
    
    validates :password, length: { minimum: 5 }
    
    has_secure_password

end
