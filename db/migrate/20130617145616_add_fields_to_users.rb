class AddFieldsToUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.boolean :active, :default => true
      t.string :role, :default => 'user'
      t.string :firstname
      t.string :lastname
      t.string :gender 
      t.date   :dob
      t.string :address_st
      t.string :address_state
      t.string :address_postcode
      t.string :address_country
    end
   # User.update_all ["receive_newsletter = ?", true]
  end
 
  def down
    #remove_column :users, :receive_newsletter
  end
end
