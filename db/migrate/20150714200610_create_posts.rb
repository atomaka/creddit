class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true, foreign_key: true
      t.references :subcreddit, index: true, foreign_key: true
      t.string :title
      t.string :link
      t.text :content

      t.timestamps null: false
    end
  end
end
