class AddAncestryToComment < ActiveRecord::Migration
  def change
    add_column :comments, :ancestry, :string
    remove_column :comments, :parent_id
  end
end
