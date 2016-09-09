class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true

      t.string :title
      t.text :content
      t.boolean :published
      t.string        :slug, index: true, uniq: true


      t.timestamps null: false
    end
  end
end
