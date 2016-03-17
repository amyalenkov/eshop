namespace :my do

  desc 'stop task'
  task :stop_task => :environment do
    p 'stop task'
    main_order = MainOrder.find_by_state MainOrder.states[:current]
    main_order.stopped!
    MainOrder.create state: MainOrder.states[:current]
    main_order.orders.each do |order|
      order.reserved!
      order.order_items.each do |order_item|
        row = order_item.product.get_row
        CartItem.create(product_id: order_item.product_id, count: order_item.count, total_price: order_item.price * order_item.count,
                        user_id: order.user_id) if row.not_full?

        if row.not_full?
          order_item.refusing_after_not_full_row!
          order_item.count = 0
        elsif row.full?
          order_item.reserved!
        end
      end
    end
    rows = Row.where state: Row.states[:not_full]
    rows.each do |row|
      row.row_items.each do |row_item|
        row_item.destroy!
      end
      row.row_comments.each do |row_comment|
        row_comment.destroy!
      end
      row.destroy!
    end
    full_rows = Row.where state: Row.states[:full]
    full_rows.each do |row|
      row.reserved!
    end

  end

end