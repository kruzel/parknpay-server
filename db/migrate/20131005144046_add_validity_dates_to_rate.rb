class AddValidityDatesToRate < ActiveRecord::Migration
  def change
    add_column :rates, :valid_start_at, :datetime
    add_column :rates, :valid_end_at, :datetime
    remove_column :payments, :rate_id
    add_index :rates, :valid_start_at
    add_index :rates, :valid_end_at
  end
end
