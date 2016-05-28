class Pick < ActiveRecord::Base
  belongs_to :stage
  has_one :picklayout
end
