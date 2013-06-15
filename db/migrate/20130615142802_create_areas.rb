class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.references :city, :null => false
      t.references :creditor, :null => false

      t.timestamps
    end
    add_index :areas, :city_id
    add_index :areas, :creditor_id
  end
end
