class Order < ActiveRecord::Base

  enum state: [:complete, :payment]

  has_many :cart_items

end
