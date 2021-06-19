class Product < ApplicationRecord
    has_many :purchases
    
    has_many :likes
end
