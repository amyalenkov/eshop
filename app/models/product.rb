class Product < ActiveRecord::Base

  has_many :cart_items
  has_many :product_params
  has_many :product_pictures
  has_many :rows
  has_many :comments

  belongs_to :subcategory

  ratyrate_rateable 'rating'

  def get_not_full_row
    rows.find_by state: Row.states[:not_full]
  end

  def get_min_sale
    result = /\d+/.match sales_notes.to_s
    result[0].to_i
  end

end
