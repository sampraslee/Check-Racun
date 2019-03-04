class HomeController < ApplicationController
  def index
    # Seperate each category of products into their own global variable for easier modification.

    @registered_products = 
    if params[:registered_search]
      Product.where("product_name ILIKE ? AND product_type = ? OR chemical ILIKE ? AND product_type = ?","%#{params[:registered_search]}%", 0, "%#{params[:registered_search]}%", 0).page params[:registered_page_no]
    else
      Product.where(product_type: 0).page params[:registered_page_no]
    end
    
    @unregistered_products =     
    if params[:unregistered_search]
      Product.where("product_name ILIKE ? AND product_type = ? OR chemical ILIKE ? AND product_type = ?","%#{params[:unregistered_search]}%", 1, "%#{params[:unregistered_search]}%", 1).page params[:unregistered_page_no]
    else
      Product.where(product_type: 1).page params[:unregistered_page_no]
    end

    @cosmetics =     
    if params[:cosmetics_search]
      Product.where("product_name ILIKE ? AND product_type = ? OR chemical ILIKE ? AND product_type = ?","%#{params[:cosmetics_search]}%", 2, "%#{params[:cosmetics_search]}%", 2).page params[:cosmetics_page_no]
    else
      Product.where(product_type: 2).page params[:cosmetics_page_no]
    end
  end
end
