class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

    ajaxful_rater

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_liker
  acts_as_follower
  acts_as_followable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :profile_name
  
  validates :first_name, presence: true

  validates :last_name, presence: true

  validates :profile_name, presence: true,
                           uniqueness: true,
                           format: {
                             with: /^[a-zA-Z0-9_-]+$/,
                             message: 'Must be formatted correctly.'
                           }

  has_many :statuses

  letsrate_rater

has_many :ratings, :dependent => :destroy 
    has_many :rated_statuses, :through => :ratings, :source => :statuses


  def full_name
  	first_name + " " + last_name
  end

  def gravatar_url
    stripped_email = email.strip
    downcased_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcased_email)

    "http://gravatar.com/avatar/#{hash}"
  end
end













