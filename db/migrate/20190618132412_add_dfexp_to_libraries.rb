class AddDfexpToLibraries < ActiveRecord::Migration[5.1]
  def change
    add_column :libraries, :dfexp, :date
  end
end
