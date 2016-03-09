class OrderItem < ActiveRecord::Base
  enum state: [:in_progress, :reserving, :reserved, :refusing_after_reserved]

  belongs_to :product
  belongs_to :order

  def set_state current_user
    if count >= product.get_min_sale
      self.state = OrderItem.states[:reserving]
    else
      row = get_row
      create_row_item row, current_user
      if row.reserving?
        self.state = OrderItem.states[:reserving]
      else
        self.state = OrderItem.states[:in_progress]
      end
    end
  end

  private

  def create_row_item row, current_user
    row_item = RowItem.new
    row_item.count=self.count
    row_item.row_id=row.id
    row_item.order_item=self
    row_item.user=current_user
    row_item.save!
  end

  def get_row
    row = self.product.get_row
    if row.nil?
      row = Row.new
      row.product = self.product
      row.min_count = self.product.get_min_sale
      row.current_count = self.count
    else
      row.current_count = row.current_count + self.count
    end
    row.save!
    row
  end

end
