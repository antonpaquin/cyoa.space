class Adventure < ActiveRecord::Base
  has_many :stages
  has_many :stagelayouts
  has_many :picklayouts
	belongs_to :account
	has_many :images
end
