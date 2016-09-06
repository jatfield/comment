class Topic < ApplicationRecord

  belongs_to :user
  has_many :posts
  has_one :last_post, -> {order 'number desc'}, class_name: "Post"
  validates :name, presence: true


end
