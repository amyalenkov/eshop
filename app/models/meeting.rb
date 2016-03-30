class Meeting < ActiveRecord::Base

  before_create :states_for_main_orders_and_orders

  belongs_to :admin_user
  belongs_to :main_order

  has_many :orders


  private

  def states_for_main_orders_and_orders
    main_order = self.main_order
    main_order.arrived!
    orders = Order.where state: Order.states[:paid], main_order: main_order
    orders.each do |order|
      order.choice_delivery!
    end
  end

end
