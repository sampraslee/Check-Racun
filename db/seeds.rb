# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# ––––––––––– Registered Products –––––––––––
def get_registered_products
    unparsed_page = HTTParty.get('https://www.npra.gov.my/index.php/en/consumers/safety-information/cancellation-of-registered-complementary-alternative-product')
    parsed_page = Nokogiri::HTML(unparsed_page)

    registered_product_name = Array.new
    parsed_page.css('table tbody tr td[2]').each do |name|
        if name.text.include? "\n"
            registered_product_name << (name.text.delete! "\n")
        else
            registered_product_name << name.text
        end
    end
    registered_product_chemical = Array.new
    parsed_page.css('table tbody tr td[6]').each do |chemical|
        if chemical.text.include? "\n"
            registered_product_chemical << (chemical.text.delete! "\n")
        else
            registered_product_chemical << chemical.text
        end
    end

    registered_products = Hash[registered_product_name.zip(registered_product_chemical)]
    registered_products.delete_if {|key, value| key == 'NAMA PRODUK'}

    registered_products.each do |name, chemical|
        registered_product = Product.create(product_name: name, chemical: chemical, product_type: 0)
    end
end
# ––––––––––– Unregistered Products –––––––––––
def get_unregistered_products
    # raw html
    unparsed_page = HTTParty.get('https://www.npra.gov.my/index.php/en/consumers/safety-information/adulterated-poducts-unregistered')
    # parsed
    parsed_page = Nokogiri::HTML(unparsed_page)

    unregistered_product_name = Array.new
    parsed_page.css("table tbody tr td[@class='ari-tbl-col-1']").each do |name|
        if name.text.include? "\n"
            unregistered_product_name << (name.text.delete! "\n")
        else
            unregistered_product_name << name.text
        end
    end

    unregistered_product_chemical = Array.new
    parsed_page.css("table tbody tr td[@class='ari-tbl-col-2']").each do |chemical|
      if chemical.text.include? "\n"
          unregistered_product_chemical << (chemical.text.delete! "\n")
      else
          unregistered_product_chemical << chemical.text
      end
    end

    unregistered_products = Hash[unregistered_product_name.zip(unregistered_product_chemical)]
    unregistered_products.delete_if {|key, value| key.empty? == true}

    unregistered_products.each do |name, chemical|
        unregistered_product = Product.create(product_name: name, chemical: chemical, product_type: 1)
    end
end

get_registered_products
get_unregistered_products