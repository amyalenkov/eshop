class PayDeliveryForProducts < ActiveRecord::Migration
  def change
    add_column :products, :is_paid_delivery, :boolean
  end
end
