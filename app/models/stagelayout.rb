class Stagelayout < ActiveRecord::Base
  has_many :stages
  belongs_to :adventure
end
