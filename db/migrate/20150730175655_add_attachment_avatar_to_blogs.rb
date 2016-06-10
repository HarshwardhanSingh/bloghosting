class AddAttachmentAvatarToBlogs < ActiveRecord::Migration
  def self.up
    change_table :blogs do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :blogs, :avatar
  end
end
