class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.references    :user
      t.string        :name
      t.string        :login
      t.string        :email
      t.string        :slug, index: true, uniq: true

      t.timestamps null: false
    end
  end
end
