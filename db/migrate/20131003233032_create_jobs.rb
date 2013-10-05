class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
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

    add_index :jobs, :expires_at
  end
end
