class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true

      t.string :title
      t.text :content
      t.boolean :published

      t.timestamps null: false
    end
  end
end
