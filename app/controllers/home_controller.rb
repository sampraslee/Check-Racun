class HomeController < ApplicationController
  def index
    # Seperate each category of products into their own global variable for easier modification.
    @registered_products = 
    if params[:registered_search]
      Product.where("product_name ILIKE ?", "%#{params[:registered_search]}%").page params[:registered_page_no]
    else
      Product.where(product_type: 0).page params[:registered_page_no]
    end
    
    @unregistered_products = Product.where(product_type: 1).page params[:unregistered_page_no]
    @cosmetics = Product.where(product_type: 2).page params[:cosmetic_page_no]
  end
end
