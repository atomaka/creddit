class CreateUserSessions < ActiveRecord::Migration
  def change
    create_table :user_sessions do |t|
      t.references :user, index: true, foreign_key: true
      t.string :key
      t.string :user_agent
      t.string :ip
      t.datetime :accessed_at

      t.timestamps null: false
    end
  end
end
