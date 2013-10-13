class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile, :text, :limit => 65535
  end
end
