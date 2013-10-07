class AddChargeToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :charge, :decimal
  end
end
