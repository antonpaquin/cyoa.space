class Adventure < ActiveRecord::Base
  has_many :stages
	belongs_to :account
	has_many :images
end
