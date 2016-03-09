class RowItem < ActiveRecord::Base
  belongs_to :row
  belongs_to :user
  belongs_to :order_item
end
