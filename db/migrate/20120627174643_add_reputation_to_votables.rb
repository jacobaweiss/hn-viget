class AddReputationToVotables < ActiveRecord::Migration
  def change
    add_column :articles, :reputation, :integer
    add_column :comments, :reputation, :integer
  end
end
