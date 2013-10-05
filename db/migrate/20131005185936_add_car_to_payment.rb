class AddCarToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :car_id, :integer
  end
end
