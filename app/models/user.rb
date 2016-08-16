class User < ApplicationRecord
 
  acts_as_authentic do |c|
    c.validate_login_field = false
    c.logged_in_timeout = 12.hours
  end

  scope :active, -> { where(active: true) }

  has_many :posts
  has_many :votes
  has_one :avatar
  has_many :topics
  has_many :uploads

  validates :email, :username, presence: true, uniqueness: true

end
