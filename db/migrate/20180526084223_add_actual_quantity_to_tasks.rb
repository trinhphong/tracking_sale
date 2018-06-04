class AddActualQuantityToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :actual_quantity, :integer, default: 0
  end
end
