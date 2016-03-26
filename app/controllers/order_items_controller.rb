class OrderItemsController < ApplicationController

  before_action :authenticate_user!

  def update
    order_item = OrderItem.find_by_id params[:id]
    order_item.comment = params[:comment]
    order_item.save!
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
    @current_total_amount = 0
    @current_total_count = 0
    @order.order_items.each do |order_item|
      @current_total_amount = @current_total_amount + order_item.count * order_item.product.price
      @current_total_count = @current_total_count + order_item.count
    end
  end

end
