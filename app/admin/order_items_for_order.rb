ActiveAdmin.register_page "OrderItemsForOrder" do

  menu label: ''

  content do
    render partial: 'current_order'
  end

  controller do
    def index
      @order_items = OrderItem.where(order_id: params[:order_id]).page(params[:page])
    end
  end

end