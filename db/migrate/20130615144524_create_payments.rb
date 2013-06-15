class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.float :x_pos
      t.float :y_pos
      t.references :street, :null => false
      t.references :area, :null => false
      t.references :city, :null => false
      t.references :creditor, :null => false
      t.references :rate, :null => false
      t.references :user, :null => false
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :archive, :default => false

      t.timestamps
    end
    add_index :payments, :street_id
    add_index :payments, :area_id
    add_index :payments, :city_id
    add_index :payments, :creditor_id
    add_index :payments, :rate_id
    add_index :payments, :user_id
  end
end
