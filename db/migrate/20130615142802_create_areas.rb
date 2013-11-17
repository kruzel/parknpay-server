class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.references :city_id, :null => false
      t.references :bank_account, :null => false

      t.timestamps
    end
    add_index :areas, :city_id
    add_index :areas, :bank_account_id
  end
end
