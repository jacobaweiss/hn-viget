class SetDefaultForReputation < ActiveRecord::Migration
  def change
    change_column :articles, :reputation, :integer, :default => 0
    change_column :comments, :reputation, :integer, :default => 0
  end
end
