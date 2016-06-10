class AddCategoryIdToProfession < ActiveRecord::Migration
  def change
    add_column :professions, :category_id, :integer
  end
end
