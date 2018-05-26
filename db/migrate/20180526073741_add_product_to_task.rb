class AddProductToTask < ActiveRecord::Migration[5.0]
  def change
     add_reference :tasks, :product, index: true
  end
end
