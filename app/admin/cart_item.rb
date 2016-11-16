ActiveAdmin.register CartItem do

  menu label: 'Корзина пользователей'

  config.per_page = 30

  filter :user, label: 'Юзер'

  index do
    column :id
    column :count
    column :user_name do |cart_item|
      cart_item.user.name
    end
    column :phone_number do |cart_item|
      cart_item.user.phone
    end
    column :user_email do |cart_item|
      cart_item.user.email
    end
    column :product_id
    column :comment
    # column "Price", sortable: :price do |product|
    #   number_to_currency product.price
    # end
    actions
  end

end
