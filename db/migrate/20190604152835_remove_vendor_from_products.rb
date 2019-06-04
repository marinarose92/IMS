class RemoveVendorFromProducts < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :vendor, :string
    add_column :products, :vendor_id, :integer
  end
end
