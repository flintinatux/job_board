class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :subdomain
      t.string :title
      t.string :tagline
      t.string :icon
      t.string :syndicates, array: true, default: '{}'

      t.timestamps
    end

    add_index :boards, :subdomain
  end
end
