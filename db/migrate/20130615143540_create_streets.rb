class CreateStreets < ActiveRecord::Migration
  def change
    create_table :streets do |t|
      t.string :name
      t.references :area, :null => false

      t.timestamps
    end
    add_index :streets, :area_id
  end
end
