class AddIndexForComments < ActiveRecord::Migration
  def up
    add_index :comments, [:commentable_id, :commentable_type]
  end

  def down
  end
end
