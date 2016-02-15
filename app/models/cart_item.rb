class CartItem < ActiveRecord::Base

  enum state: [:in_progress, :in_order]

  belongs_to :user
  belongs_to :product
  belongs_to :row
  belongs_to :order
end
