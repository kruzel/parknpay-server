class AddAttachmentAvatarToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :avatar
    end
    User.update_all ["avatar_file_name = ?", "/public/img/User-icon.png"]
  end

  def self.down
    drop_attached_file :users, :avatar
  end
end
