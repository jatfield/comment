class Upload < ApplicationRecord
  has_attached_file :file
  validates_attachment_content_type :file, content_type: /\Aimage/
  validates_attachment_file_name :file, matches: [/png\Z/, /jpe?g\Z/]
  belongs_to :user
  belongs_to :post

  validates :user, :post, presence: true
  validates :file, attachment_presence: true
end
