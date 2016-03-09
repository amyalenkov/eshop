class OrderItemsController < ApplicationController

  before_action :authenticate_user!

  def update

  end

  def destroy
    order_item  = OrderItem.find_by_id params[:id]
    order_item.destroy!
    @order = current_user.get_current_order
  end

end
