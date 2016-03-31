class Order < ActiveRecord::Base

  enum state: [:in_progress, :stopped,
               :refusing_after_reserved, :bill,
               :paid, :not_paid, :refund,
               :choice_delivery, :delivering, :delivered]
  enum payment_type: [:not_choice, :offline, :card]
  enum delivery: [:not_choice_delivery, :courier, :post, :meeting]

  has_many :order_items

  belongs_to :user

  belongs_to :meeting

  belongs_to :main_order

  def get_refunding
    count = 0
    order_items.each { |order_item|
      count  = count + 1 if order_item.refund?
    }
    count
  end

  def get_refunded
    count = 0
    order_items.each { |order_item|
      count  = count + 1 if order_item.refunded?
    }
    count
  end

end
