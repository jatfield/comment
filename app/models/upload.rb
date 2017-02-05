class Upload < ApplicationRecord
  has_attached_file :file, styles: {
                                       thumb: "150x150>",
                                       medium: "800x800>" },
                           convert_options: {
                                       thumb: "-quality 75 -strip" },
                           url: "/system/:hash.:extension",
                           hash_secret: "27c304329f9ed4d22ef3e285c9c284104d4d44949f86fba1e2a062fef053aee3cb9c87690b898842026608b2023d30ce3c1b9c84df02fd4cc17d3e646e4b8452"
  validates_attachment_content_type :file, content_type: ["image/jpeg", "image/gif", "image/png"]
  belongs_to :user
  belongs_to :post

  validates :user, :post, presence: true
  validates :file, attachment_presence: true
end
