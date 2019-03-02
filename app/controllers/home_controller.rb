class HomeController < ApplicationController
  def index
    # Seperate each category of products into their own global variable for easier modification.
    @registered_products = Product.where(product_type: 0).page params[:registered_page_no]
    @unregistered_products = Product.where(product_type: 1).page params[:unregistered_page_no]
  end
end
