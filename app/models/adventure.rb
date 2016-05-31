class Adventure < ActiveRecord::Base
  has_many :stages
  has_many :stagelayouts, through: :stages
	belongs_to :account
	has_many :images
end
