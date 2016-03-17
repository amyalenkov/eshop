class OrderItem < ActiveRecord::Base
  enum state: [:in_progress, :reserved, :refusing_after_not_full_row, :refusing_after_reserved, :bill]

  belongs_to :product
  belongs_to :order

  def set_state current_user
    row = get_row
    create_row_item row, current_user
  end

  def get_row_after_stop
    Row.find_by product: product, state: [Row.states[:reserved],Row.states[:refusing]]
  end

  private

  def create_row_item row, current_user
    row_item = RowItem.find_by row_id: row.id, user_id: current_user.id
    if row_item.nil?
      row_item = RowItem.new
      row_item.count=self.count
      row_item.row_id=row.id
      row_item.user=current_user
    else
      row_item.count=row_item.count + self.count
    end
    row_item.order_item=self
    row_item.save!
  end

  def get_row
    row = self.product.get_row
    if row.nil?
      row = Row.new
      row.product = self.product
      row.min_count = self.product.get_min_sale
      row.current_count = self.count
      row.main_order = MainOrder.find_by state: MainOrder.states[:current]
    else
      row.current_count = row.current_count + self.count
    end
    row.save!
    row
  end

end
