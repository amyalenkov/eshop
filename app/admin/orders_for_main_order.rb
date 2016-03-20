ActiveAdmin.register_page "OrdersForMainOrder" do
  content do
    render partial: 'current_order'
  end

  controller do
    def index
      @orders = Order.where(main_order_id: params[:main_order_id]).page(params[:page])
    end
  end

end