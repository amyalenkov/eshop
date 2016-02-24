class CartItem < ActiveRecord::Base

  enum state: [:in_cart, :in_order]

  belongs_to :user
  belongs_to :product
  belongs_to :row
  belongs_to :order

  def get_product_name
    product.name
  end

  def in_row?
    !Row.find_by(product: product, state: Row.states[:not_full]).nil?
  end

  def get_row
    Row.find_by(product: product, state: Row.states[:not_full])
  end

  def for_new_row?
    if in_order?
      false
    elsif !row.nil?
      false
    else
      if count >= product.get_min_sale
        false
      else
        !in_row?
      end
    end
  end

  def possible_to_order?
    if in_order?
      false
    else
      if count >= product.get_min_sale
        true
      else
        if row.nil?
          false
        else
          row.full?
        end
      end
    end
  end

end
