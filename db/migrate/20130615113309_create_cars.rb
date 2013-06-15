class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.references :user, :null => false
      t.string :license_plate, :null => false
      t.string :car_description, :null => false
      t.attachment :car_image
      t.boolean :archive, :default => false

      t.timestamps
    end
    add_index :cars, :user_id
  end
end
