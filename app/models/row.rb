class Row < ActiveRecord::Base

  after_update :check_bill_state, :if => :state_changed?
  before_save :check_state, :if => :current_count_changed?
  before_update :check_state, :if => :current_count_changed?

  enum state: [:not_full, :full, :reserved, :bill,:refusing]

  belongs_to :product
  belongs_to :main_order

  has_many :row_items
  has_many :row_comments

  def check_bill_state
    p 'check_bill_state'
    # if self.state == Row.states[:bill]
      p self.state
      p self.row_items
      self.row_items.each do |row_item|
        order_item = row_item.order_item
        order_item.bill!
        p order_item
        order = order_item.order
        p order
        order.bill!
        if order.total_price.nil?
          order.total_price = order_item.count * order_item.product.price
        else
          order.total_price = order.total_price + order_item.count * order_item.product.price
        end
        order.save!
      end
    # end
  end

  def check_state
    p 'check_state'
    if current_count >= min_count
      self.state = Row.states[:full]
      self.row_items.each do |row_item|
        row_item.order_item.reserving!
      end
    else
      self.state = Row.states[:not_full]
      self.row_items.each do |row_item|
        order_item = row_item.order_item
        order_item.in_progress! unless order_item.nil?
      end
    end
  end

end
