class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.date :date
      t.string :library
      t.string :product
      t.decimal :price
      t.string :serial_no
      t.string :vendor
      t.string :po_no

      t.timestamps
    end
  end
end
