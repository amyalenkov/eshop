class Order < ActiveRecord::Base

  enum state: [:complete, :payment_in_progress, :paid, :will_paid_offline]
  enum payment_type: [:not_choice, :offline, :card]
  enum delivery: [:not_choice_delivery, :courier, :take_away_himself, :meeting]

  has_many :cart_items

  belongs_to :user

  belongs_to :meeting

end
