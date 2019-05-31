class RemoveProductFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :product, :string
    add_column :orders, :product_id, :integer
  end
end
