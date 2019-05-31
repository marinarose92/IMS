class RemoveLibraryNameFromLibraries < ActiveRecord::Migration[5.1]
  def change
    remove_column :libraries, :library_name, :string
    add_column :libraries, :name, :string
  end
end
