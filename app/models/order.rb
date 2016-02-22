class Order < ActiveRecord::Base

  enum state: [:complete, :payment_in_progress, :paid, :will_paid_offline]
  enum payment_type: [:not_choice, :offline, :card]

  has_many :cart_items

  belongs_to :user

end
