class Topic < ApplicationRecord
  belongs_to :user
  has_many :posts

  validates :user, :name, presence: true

  def last_post

    self.posts.order(number: :desc).first

  end

end
