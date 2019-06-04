class RemoveVendorFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :vendor, :string
    add_column :orders, :vendor_id, :integer
  end
end
