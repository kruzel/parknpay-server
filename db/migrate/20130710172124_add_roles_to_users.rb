class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :inspector, :boolean
    add_column :users, :customer, :boolean
    add_column :users, :admin, :boolean
  end
end
