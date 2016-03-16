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
        CartItem.create(product_id: order_item.product_id, count: order_item.count, total_price: order_item.price * order_item.count,
                        user_id: order.user_id) if order_item.in_progress?
        if order_item.in_progress?
          order_item.refusing_after_not_full_row!
          order_item.count = 0
        elsif order_item.reserving?
          order_item.reserved!
        end
      end
    end
    rows = Row.all
    rows.each do |row|
      row.row_items.each do |row_item|
        row_item.destroy!
      end
      row.row_comments.each do |row_comment|
        row_comment.destroy!
      end
      row.destroy!
    end
  end

end