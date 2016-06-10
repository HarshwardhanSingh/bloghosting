class AddTriggerUserIdToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :trigger_user_id, :integer
  end
end
