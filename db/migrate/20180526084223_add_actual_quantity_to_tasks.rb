class AddActualQuantityToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :actual_quantity, :integer
  end
end
