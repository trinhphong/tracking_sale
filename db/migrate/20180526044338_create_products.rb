class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :img_url
      t.float  :price, default: 0

      t.timestamps
    end
  end
end
