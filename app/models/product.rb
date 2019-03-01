class Product < ApplicationRecord
    enum product_type: [:registered, :unregistered, :cosmetic]
end
