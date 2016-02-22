class CartItem < ActiveRecord::Base

  enum state: [:in_cart, :in_order]

  belongs_to :user
  belongs_to :product
  belongs_to :row
  belongs_to :order

  def get_product_name
    get_product.name
  end

  def possible_to_order?
    if count >= get_min_sale
      true
    else
      false
    end
  end

  def get_min_sale
    result = /\d+/.match get_product.sales_notes.to_s
    result[0].to_i
  end

  def get_product
    Product.find_by_id product_id
  end
end
