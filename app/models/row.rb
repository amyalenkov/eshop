class Row < ActiveRecord::Base

  before_update :check_state, :if => :current_count_changed?

  enum state: [:not_full, :full, :reserving, :reserved, :refusing]

  belongs_to :product

  has_many :row_items

  def check_state
    p 'check_state'
    if current_count >= min_count
      self.state = Row.states[:reserving]
      self.row_items.each do |row_item|
        row_item.order_item.reserving!
      end
    end
  end

end
