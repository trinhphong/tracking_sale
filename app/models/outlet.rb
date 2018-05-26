class Outlet < ApplicationRecord
  has_many :taskoutlets

  has_many :outletproducts
  has_many :products, through: :outletproducts
end
