class AddVendorToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :vendor, :string
  end
end
