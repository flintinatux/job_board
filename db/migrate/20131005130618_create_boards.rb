class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :subdomain
      t.string :title
      t.string :tagline
      t.string :icon
      t.string :syndicates, array: true, default: '{}'
      t.string :suggestions
      t.text   :benefits
      t.money  :price
      t.string :uuid,       null: false, limit: 36

      t.timestamps
    end

    add_index :boards, :subdomain
  end
end
