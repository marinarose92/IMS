class RemoveLibraryFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :library, :string
    add_column :orders, :library_id, :integer
  end
end
