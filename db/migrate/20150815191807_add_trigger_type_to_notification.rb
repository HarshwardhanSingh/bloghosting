class AddTriggerTypeToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :trigger_type, :string
  end
end
