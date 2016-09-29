class Product < ActiveRecord::Base

  has_many :cart_items
  has_many :product_params
  has_many :product_pictures
  has_many :comments
  has_many :favorites

  belongs_to :subcategory
  # has_one :country
  # has_one :trademark

  ratyrate_rateable 'rating'

  def get_row
    Row.find_by(product_id: id, state: [Row.states[:full], Row.states[:not_full]])
  end

  def get_min_sale
    result = /\d+/.match min_qty.to_s
    result[0].to_i
  end

  def get_price
    course = Additional.find_by_name('course').value

    markup = get_mark_up
    Rails.logger.warn 'get_mark_up: '+markup

    result_price = ((price.to_f * course.to_f * (markup.to_f/100 +1)).round 2).to_i
    str_result_price = result_price.to_s
    second_part = str_result_price[-3, 3].to_i.round -2
    first_part = str_result_price.gsub( /.{3}$/, '' )
    if first_part.size > 3
      million_part = str_result_price.gsub( /.{6}$/, '' )
      first_part = str_result_price.gsub( /.{3}$/, '' ).gsub( /^\w/, '' )
      if second_part == 0
        second_part = '000'
      elsif second_part == 1000
        second_part = '000'
        first_part = (first_part.to_i + 1).to_s
      end
      million_part + ' ' + first_part + ' ' + second_part.to_s
    else
      if second_part == 0
        second_part = '000'
      elsif second_part == 1000
        second_part = '000'
        first_part = (first_part.to_i + 1).to_s
      end
      first_part + ' ' + second_part.to_s
    end
  end

  def get_new_price
    course = Additional.find_by_name('course').value
    markup = get_mark_up
    Rails.logger.warn 'get_mark_up: '+markup.to_s
    (((price.to_f * course.to_f * (markup.to_f/100 +1)).round 2)/10000).round 2
  end

  def get_mark_up
    Rails.logger.warn 'get_mark_up'
    category_id = /(\w+)/.match(Category.find_by_sid(subcategory_id).path.to_s)[1]
    Rails.logger.warn 'category_id: '+category_id.to_s

    markup_category = Category.find_by_id(category_id).mark_up
    markup_default = Additional.find_by_name('markup').value

    if markup_category != nil && markup_category != ''
      markup_category
    else
      markup_default
    end
  end

  def get_price_int
    get_price.gsub(/\s+/, '').to_i
  end

  def get_favorite user
    Favorite.find_by(user_id: user.id, product_id: id)
  end

end
