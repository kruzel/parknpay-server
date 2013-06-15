class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.float :rate
      t.string :currency
      t.references :area, :null => false
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :archive, :default => false

      t.timestamps
    end
    add_index :rates, :area_id
  end
end
