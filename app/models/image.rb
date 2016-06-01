class Image < ActiveRecord::Base
  has_attached_file :image
  belongs_to :adventure

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
