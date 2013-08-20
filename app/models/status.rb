class Status < ActiveRecord::Base
  attr_accessible :content, :user_id, :avatar , :rating_sum
  belongs_to :user
  # before_filter :authenticate_user
  acts_as_likeable
  has_many :likes
 letsrate_rateable "avatar"
  # opinio_subjectum

 # validates :content presence: true,
                      #length: { minimum: 0 }

  validates :user_id, presence: true

 ajaxful_rateable :stars => 5, :dimensions => [:avatar]


has_attached_file :avatar, :styles => { :medium => "500x500>", :small => "300x300>",:thumb => "100x100>" }, :default_url => "/assets/missing.png"
validates_attachment_presence :avatar
validates_attachment_size :avatar, :less_than => 5.megabytes
validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png' , 'image/gif']



    has_many :raters, :through => :ratings, :source => :users

has_many :ratings, :dependent => :destroy

#def average_rating
 #   @value = 0
 #   self.ratings.each do |rating|
  #      @value = @value + rating.value
 #   end
 #   @total = self.ratings.size
  #  @value.to_f / @total.to_f
#end

# returns the number of ratings for that photo
def count_ratings
  self.ratings.all.count
end

# returns the average rating for that photo
def avg_rating
  @avg = self.ratings.average(:stars)     
  @avg ? @avg : 0
end
end