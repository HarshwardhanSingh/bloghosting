class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :notice

      t.timestamps null: false
    end
  end
end
