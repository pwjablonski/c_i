class User < ActiveRecord::Base
  enum role: [:student, :teacher, :admin]
#  after_initialize :set_default_role, :if => :new_record?

#  def set_default_role
#    self.role ||= :admin
#  end

   
    # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

    

  has_many :classrooms
  
  has_one :profile
  
end
