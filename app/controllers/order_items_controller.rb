class OrderItemsController < ApplicationController

  before_action :authenticate_user!

  def update

  end

  def destroy
    order_item  = OrderItem.find_by_id params[:id]
    row = order_item.row
    row.current_count = row.current_count - order_item.count
    if row.current_count == 0
      row.destroy!
    else
      row.save!
    end
    CartItem.create count: order_item.count, user: current_user, product: order_item.product
    order_item.destroy!
    @order = current_user.get_current_order
  end

end
