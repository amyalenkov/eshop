class Order < ActiveRecord::Base

  enum state: [:complete, :payment]

  has_many :cart_items

  belongs_to :user

end
