class Order < ActiveRecord::Base

  enum state: [:in_progress, :reserved,
               :refusing_after_reserved, :bill,
               :paid, :not_paid, :refund]
  enum payment_type: [:not_choice, :offline, :card]
  enum delivery: [:not_choice_delivery, :courier, :take_away_himself, :meeting]

  has_many :order_items

  belongs_to :user

  belongs_to :meeting

  belongs_to :main_order

end
