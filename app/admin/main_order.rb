ActiveAdmin.register MainOrder do

  menu label: 'СП'

  config.per_page = 30

  filter :state

  index do
    column 'id', :id
    column 'Дата создания', :created_at
    column 'Статус', :state
    column 'Пользователи' do |main_order|
      link_to 'users', admin_ordersformainorder_path(main_order_id: main_order.id)
    end
    column 'Ряды' do |main_order|
      link_to 'rows', admin_rowsformainorder_path(main_order_id: main_order.id)
    end
    column 'Итоговая сумма', :full_amount
  end

  show do
    attributes_table do
      row :id
      row :state
      row 'Пользователи' do |main_order|
        link_to 'users', admin_ordersformainorder_path(main_order_id: main_order.id)
      end
      row 'Ряды' do |main_order|
        link_to 'rows', admin_rowsformainorder_path(main_order_id: main_order.id)
      end
    end
  end

  permit_params :state

  form do |f|
    f.inputs 'Edit Main Order' do
      f.input :state, as: :select, collection: MainOrder.states.keys
    end
    f.actions
  end

end
