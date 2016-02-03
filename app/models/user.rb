class User < ActiveRecord::Base
  enum role: [:student, :teacher, :admin]
  validates :role, presence: true
  
#  after_initialize :set_default_role, :if => :new_record?

#  def set_default_role
#    self.role ||= :admin
#  end

       # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :confirmable, :validatable, :omniauthable, :omniauth_providers => [:github]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.role = :student
      
      #user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      user.repos = auth.
      
      user.skip_confirmation!
      user.save!
    end
  end

  def public_repos
      
      
      repos = HTTParty.get("https://api.github.com/users/#{self.student.github_username}/repos", :headers => {"User-Agent" => "#{self.student.github_username}"})
      
      return repos
      
  end



  has_one :teacher
  has_one :student
  has_many :classrooms, through: :teachers
  has_many :students, through: :classrooms

  
end
