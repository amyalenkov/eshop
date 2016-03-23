class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_filter :set_menu

  def order_call

  end
  private

  def set_menu
    @categories = Category.includes :subcategories
    @categories = @categories.page(1).per(50)
  end

end
