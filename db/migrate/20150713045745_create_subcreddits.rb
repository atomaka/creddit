class CreateSubcreddits < ActiveRecord::Migration
  def change
    create_table :subcreddits do |t|
      t.references :owner, index: true, foreign_key: true
      t.string :name
      t.string :slug
      t.datetime :closed_at

      t.timestamps null: false
    end
  end
end
