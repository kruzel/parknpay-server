class AddtermsOfServiceToUser < ActiveRecord::Migration
  def up
      add_column :users, :terms_of_service, :boolean
  end

  def down
    remove_column :users, :terms_of_service
  end
end
