class RowComment < ActiveRecord::Base
  belongs_to :row
  belongs_to :user
end
