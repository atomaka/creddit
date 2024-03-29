class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true
      t.string :ancestry
      t.text :content

      t.timestamps null: false
    end

    add_index :comments, :ancestry
  end
end
