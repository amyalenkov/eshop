class AddSertificateAndBoxTypeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :certificate_type, :string
    add_column :products, :box_type, :string
  end
end
