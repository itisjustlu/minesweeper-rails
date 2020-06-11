class CreateBoards < ActiveRecord::Migration[5.1]
  def change
    create_table :boards do |t|
      t.string :state
      t.integer :columns
      t.integer :rows
      t.integer :mines
      t.datetime :finished_at

      t.timestamps
    end
  end
end
