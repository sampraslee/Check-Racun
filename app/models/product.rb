class Product < ApplicationRecord
    enum product_type: [:registered, :unregistered, :cosmetic]

    paginates_per 8
end
