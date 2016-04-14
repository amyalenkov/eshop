class CreateTrademarks < ActiveRecord::Migration
  def change
    create_table :trademarks do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end
  end
end
