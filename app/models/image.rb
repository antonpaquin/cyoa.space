class Image < ActiveRecord::Base
  has_attached_file :image
  belongs_to :adventure
end
