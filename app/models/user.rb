class User < ApplicationRecord
 
  acts_as_authentic do |c|
#    c.validate_login_field = false
c.crypto_provider = ::Authlogic::CryptoProviders::SCrypt
    c.logged_in_timeout = 12.hours
  end

  scope :active, -> { where(active: true) }

  def self.find_by_activated_user(username)
    self.find_by_username_and_active(username, true)
  end

  has_many :posts
  has_many :votes
  has_one :avatar
  has_many :topics
  has_many :uploads
  has_many :topic_visits
  belongs_to :font_size
  belongs_to :posts_per_page

  validates :email, :username, presence: true, uniqueness: true

end
