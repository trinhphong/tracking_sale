class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.date       :date
      t.references :user
      t.references :admin
      t.float      :latitude
      t.float      :longitude

      t.timestamps
    end
  end
end
