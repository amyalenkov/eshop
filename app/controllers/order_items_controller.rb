class OrderItemsController < ApplicationController

  before_action :authenticate_user!

  def update

  end

  def destroy
    order_item  = OrderItem.find_by_id params[:id]
    row = Row.find_by_product_id order_item.product.id
    row_item = RowItem.find_by row_id: row.id, user_id: current_user.id
    row.current_count = row.current_count - row_item.count
    row.check_state
    row_item.destroy! unless row_item.nil?
    if row.current_count == 0
      row.destroy!
    else
      row.save!
    end
    CartItem.create count: order_item.count, total_price: order_item.price, user: current_user, product: order_item.product
    order_item.destroy!
    @order = current_user.get_current_order
  end

end
