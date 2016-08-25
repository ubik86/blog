class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.references :postable, polymorphic: true
      t.references :person
      t.references :user
      t.datetime   :confirmed_at

      t.timestamps null: false
    end
  end
end
