class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :person
      t.references :friend

      t.boolean    :accepted, null: false
      t.datetime   :confirmed_at

      t.timestamps null: false
    end

  add_index :friendships, [:person_id, :friend_id],     unique: true
  add_index :friendships, :person_id
  add_index :friendships, :friend_id
  end
end
