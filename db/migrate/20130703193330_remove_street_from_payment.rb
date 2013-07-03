class RemoveStreetFromPayment < ActiveRecord::Migration
  def up
    remove_column :payments, :street_id
  end

  def down
    add_column :payments, :street, :references
  end
end
