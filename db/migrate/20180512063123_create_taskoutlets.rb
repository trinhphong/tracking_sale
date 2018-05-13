class CreateTaskoutlets < ActiveRecord::Migration[5.0]
  def change
    create_table :taskoutlets do |t|
      t.references :task, index: true, foreign_key: true
      t.references :outlet, index: true, foreign_key: true

      t.timestamps
    end
  end
end
