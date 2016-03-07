class OrderItem < ActiveRecord::Base
  enum state: [:in_progress, :reserved, :refusing_after_reserved]
  belongs_to :product
  belongs_to :order
end
