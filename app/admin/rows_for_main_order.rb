ActiveAdmin.register_page "RowsForMainOrder" do
  content do
    render partial: 'current_order'
  end

  controller do
    def index
      @main_order_id = params[:main_order_id]
      @rows = Row.where(main_order_id: params[:main_order_id]).page(params[:page])
    end
  end

end