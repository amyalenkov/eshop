class Meeting < ActiveRecord::Base

  belongs_to :admin_user

  has_many :orders
end
