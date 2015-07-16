class AddIndexToSubcredditSlug < ActiveRecord::Migration
  def change
    add_index :subcreddits, :slug, unique: true
  end
end
