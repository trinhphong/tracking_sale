class AddCheckInToTaskoutlets < ActiveRecord::Migration[5.0]
  def change
    add_column :taskoutlets, :check_in, :boolean, default: false
  end
end
