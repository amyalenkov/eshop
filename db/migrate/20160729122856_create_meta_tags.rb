class CreateMetaTags < ActiveRecord::Migration
  def change
    create_table :meta_tags do |t|
      t.text :name
      t.text :title
      t.text :description
    end
  end
end
