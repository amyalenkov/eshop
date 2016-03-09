class CartItem < ActiveRecord::Base

  belongs_to :user
  belongs_to :product

  def get_product_name
    product.name
  end

  def get_not_full_product_row
    Row.find_by(product: product, state: Row.states[:not_full])
  end

  def get_not_full_product_row
    Row.find_by(product: product, state: Row.states[:not_full])
  end

end
