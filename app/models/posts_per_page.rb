class PostsPerPage < ApplicationRecord

  validates :value, presence: true, uniqueness: true
  has_many :users, dependent: :nullify

end
