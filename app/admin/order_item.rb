ActiveAdmin.register OrderItem do

  menu label: 'Пункты заказа'

  index do
    column 'id' do |order_item|
      link_to "#{order_item.id}", 'order_items/'+order_item.id.to_s
    end
    column 'Кол-во', :count
    column 'ID продукта', :product_id
    column 'Статус', :state
    column 'Дата создания', :created_at
    column 'Итоговая сумма', :price
    column 'Комментарий', :comment
  end

  form do |f|
    f.inputs 'Edit Order_item' do
      f.input :state, as: :select, collection: OrderItem.states.keys
      f.input :price
    end
    f.actions
  end

  permit_params :state

  config.per_page = 30

  filter :state

end
