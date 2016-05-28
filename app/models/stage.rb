class Stage < ActiveRecord::Base
  belongs_to :adventure
  has_many :picks
  belongs_to :stagelayout

end
