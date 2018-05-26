class CreateJoinTableOutletsProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :outletproducts do |t|
      t.references :outlet, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
    end
  end
end
