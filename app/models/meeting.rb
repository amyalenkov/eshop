class Meeting < ActiveRecord::Base

  belongs_to :admin_user
  belongs_to :main_order

  has_many :orders
end
