class AddQuantityToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :quantity, :integer, default: 0
  end
end
