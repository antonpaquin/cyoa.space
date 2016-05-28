class Stage < ActiveRecord::Base
  belongs_to :adventure
  has_many :picks
  has_one :stagelayout
  
end
