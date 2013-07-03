class RemoveCreditorAndCityFromPayment < ActiveRecord::Migration
  def up
    remove_column :payments, :city_id
    remove_column :payments, :creditor_id
  end

  def down
    add_column :payments, :creditor, :references, :null => false
    add_column :payments, :city, :references, :null => false
  end
end
