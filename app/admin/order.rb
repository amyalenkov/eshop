ActiveAdmin.register Order do

  menu label: 'Заказы'

  permit_params :state, :total_price

  config.per_page = 30

  filter :state

  form do |f|
    f.inputs 'Edit Order' do
      f.input :state, as: :select, collection: Order.states.keys
      f.input :total_price
    end
    f.actions
  end


end
