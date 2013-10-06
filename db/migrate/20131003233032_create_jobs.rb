class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string    :title
      t.integer   :category_id
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

    add_index :jobs, :expires_at
    add_index :jobs, [:category_id, :expires_at]
  end
end
