class AddSaleToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :expect_sale, :float, default: 0
    add_column :tasks, :actual_sale, :float, default: 0
  end
end
