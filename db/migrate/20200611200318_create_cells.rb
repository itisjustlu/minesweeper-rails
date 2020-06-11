class CreateCells < ActiveRecord::Migration[5.1]
  def change
    create_table :cells do |t|
      t.integer :row
      t.integer :column
      t.string :type
      t.string :state
      t.integer :flagged
      t.boolean :clicked
      t.references :board, foreign_key: true

      t.timestamps
    end
  end
end
