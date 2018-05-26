class Product < ApplicationRecord
  has_many :outletproducts
  has_many :outlets, through: :outletproducts
end
