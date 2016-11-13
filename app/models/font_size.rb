class FontSize < ApplicationRecord

  validates :name, :value, presence: true, uniqueness: true
  has_many :users, dependent: :nullify

end
