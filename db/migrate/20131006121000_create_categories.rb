class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :board_id
      t.string  :name
      t.string  :uuid,      null: false, limit: 36

      t.timestamps
    end

    add_index :categories, :board_id
  end
end
