class RemoveImageNameFromArticles < ActiveRecord::Migration[5.0]
  def change
    remove_column :articles, :image_name, :string
  end
end
