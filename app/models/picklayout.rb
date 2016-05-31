class Picklayout < ActiveRecord::Base
  has_many :picks
  belongs_to :adventure
end
