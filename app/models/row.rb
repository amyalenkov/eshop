class Row < ActiveRecord::Base

  # before_save :check_state, :if => :current_count_changed?
  before_update :check_state, :if => :current_count_changed?

  enum state: [:not_full, :full,
               :reserved,
               :refusing_after_reserved, :bill,
               :paid, :not_full_after_bill,
               :refusing_after_bill, :ordered]

  belongs_to :product
  belongs_to :main_order

  has_many :row_items
  has_many :row_comments
  has_many :order_items

  def check_state
    p 'check_state'
    if current_count >= min_count
      self.state = Row.states[:full]
    else
      self.state = Row.states[:not_full]
    end
  end

end
