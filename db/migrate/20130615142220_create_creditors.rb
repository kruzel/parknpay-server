class CreateCreditors < ActiveRecord::Migration
  def change
    create_table :creditors do |t|
      t.string :name
      t.string :bank_name
      t.string :bank_code
      t.string :bank_office
      t.string :bank_account
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone
      t.boolean :archive, :default => false

      t.timestamps
    end
  end
end
