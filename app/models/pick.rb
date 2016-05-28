class Pick < ActiveRecord::Base
  belongs_to :stage
  belongs_to :picklayout
end
