class CreateCells < ActiveRecord::Migration[5.1]
  def change
    create_table :cells do |t|
      t.integer :row
      t.integer :column
      t.string :type
      t.integer :flag
      t.integer :mines_around
      t.boolean :clicked
      t.references :board, foreign_key: true

      t.timestamps
    end
  end
end
