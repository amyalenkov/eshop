class AddPaidAmountToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :paid_amount, :decimal
  end
end
