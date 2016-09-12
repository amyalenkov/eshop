class DateForOrders < ActiveRecord::Migration
  def change
    create_table :date_for_orders do |t|
      t.text :name
      t.text :date
      t.text :description
    end
  end
end
