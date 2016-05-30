class Adventure < ActiveRecord::Base
  has_many :stages
  has_many :picks, through: :stages
  has_many :stagelayouts, through: :stages
  has_many :picklayouts, through: :picks
	belongs_to :account
	has_many :images
end
