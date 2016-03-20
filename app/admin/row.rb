ActiveAdmin.register Row do

  # permit_params :state

  config.per_page = 30

  # config.filters = false
  # # scope :rows, default: true
  #
  # controller do
  #   def index
  #     @rows = Row.where(main_order_id: params[:main_order_id]).page(params[:page])
  #     @row = @rows[0]
  #   end
  # end

end
