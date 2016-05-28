class Adventure < ActiveRecord::Base
  has_many :stages

  #TODO make some validations so I don't end up with rogue <script> tags in a description somewhere
end
