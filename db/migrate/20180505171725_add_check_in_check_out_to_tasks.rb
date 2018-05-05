class AddCheckInCheckOutToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :check_in, :boolean, default: false
    add_column :tasks, :check_out, :boolean, default: false
  end
end
