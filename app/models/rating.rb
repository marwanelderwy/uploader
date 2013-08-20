class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :status

  attr_accessible :rating_value

  validates :user_id, :presence => true
  validates :status_id, :presence => true
  #validates :stars, :presence => true, :numericality => true, :inclusion => { :in => 0..5 }
end