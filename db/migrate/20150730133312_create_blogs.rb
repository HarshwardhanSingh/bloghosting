class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :name
      t.text :desc
      t.string :type_of
      t.string :link

      t.timestamps null: false
    end
  end
end
