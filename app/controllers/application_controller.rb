class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_filter :set_menu
  # before_filter :get_submenu

  private

  def set_menu
    @categories = Category.includes :subcategories
  end

  def get_submenu_by_category_id id
    @subcategories = Subcategory.find_by_category_id id
  end
end
