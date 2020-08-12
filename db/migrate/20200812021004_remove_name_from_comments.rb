class RemoveNameFromComments < ActiveRecord::Migration[5.0]
  def change
    remove_column :comments, :name, :string
  end
end
