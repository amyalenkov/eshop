class CartItem < ActiveRecord::Base

  enum state: [:in_cart, :in_order]

  belongs_to :user
  belongs_to :product
  belongs_to :row
  belongs_to :order

  def get_product_name
    product = Product.find_by_id product_id
    product.name
  end
end
