class User < ActiveRecord::Base
   
#   after_create :notify_admin

   
   enum role: [:student, :teacher, :admin]
   acts_as_messageable
   
   has_one :teacher
   has_one :student
   has_many :classrooms, through: :teachers
   has_many :students, through: :classrooms
   
   
   
#  after_initialize :set_default_role, :if => :new_record?

#  def set_default_role
#    self.role ||= :admin
#  end

       # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :timeoutable, :registerable, :recoverable, :rememberable, :trackable, :confirmable, :validatable, :omniauthable, :omniauth_providers => [:github]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.role = :student
      
      #user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      # user.repos = auth.info.public_repos
      
      user.skip_confirmation!
      user.save!
    end
  end

  def public_repos
      repos = HTTParty.get("https://api.github.com/users/#{self.student.github_username}/repos", :headers => {"User-Agent" => "#{self.student.github_username}"})
      return repos
  end


#  def active_for_authentication?
#     super && approved?
#  end
#
#  def inactive_message
#    if !approved?
#        :not_approved
#    else
#        super # Use whatever other message
#    end
#  end

   def self.active_users
        all.where(current_sign_in_at: (Time.now - 1.days.. Time.now))
    end

  def name
    return "Peter"
  end

  def mailboxer_email(object)
    email
  end




end
