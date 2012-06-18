class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :null => false
      t.string :crypted_password, :null => false
 
      t.timestamps
    end
  end
end
