class Avatar < ApplicationRecord
  has_attached_file :picture
  validates_attachment_content_type :picture, content_type: /\Aimage/
  validates_attachment_file_name :picture, matches: [/png\Z/, /jpe?g\Z/]
  belongs_to :user

  validates :user, presence: true
  validates :picture, attachment_presence: true
end
