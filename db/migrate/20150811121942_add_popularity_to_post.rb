class AddPopularityToPost < ActiveRecord::Migration
  def change
    add_column :posts, :popularity, :double
  end
end
