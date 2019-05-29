class AddDfLicColumnToLibraries < ActiveRecord::Migration[5.1]
  def change
    add_column :libraries, :df_lic, :integer
  end
end
