class AddPriorityToTaskoutlets < ActiveRecord::Migration[5.0]
  def change
    add_column :taskoutlets, :priority, :integer
  end
end
