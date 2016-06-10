class AddUnreadToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :unread, :integer,default: '1'
  end
end
