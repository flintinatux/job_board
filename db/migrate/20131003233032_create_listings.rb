class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string    :title
      t.string    :category
      t.string    :location
      t.text      :description
      t.string    :instructions
      t.datetime  :expires_at
      t.boolean   :highlight
      t.string    :company
      t.string    :url
      t.string    :email

      t.timestamps
    end

    add_index :listings, :expires_at
  end
end
