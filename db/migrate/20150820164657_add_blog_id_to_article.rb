class AddBlogIdToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :blog_id, :integer
  end
end
