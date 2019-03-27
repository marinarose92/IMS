class CreateVendors < ActiveRecord::Migration[5.1]
  def change
    create_table :vendors do |t|
      t.string :vendor_name

      t.timestamps
    end
  end
end
