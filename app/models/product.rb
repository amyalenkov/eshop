class Product < ActiveRecord::Base

  has_many :cart_items
  has_many :product_params
  has_many :product_pictures
  has_many :rows

  belongs_to :subcategory

end
