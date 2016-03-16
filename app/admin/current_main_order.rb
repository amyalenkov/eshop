ActiveAdmin.register_page "CurrentMainOrder" do
  content do
    render partial: 'current_order'
  end

  action_item :view_site do
    link_to "View Site", "/"
  end

  page_action :add_event, method: :post do
    # ...
    redirect_to 'admin_calendar_path', notice: "Your event was added"
  end
end