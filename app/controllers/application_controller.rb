class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_filter :set_menu

  private

  def set_menu
    @categories = Category.includes :subcategories
  end

end
