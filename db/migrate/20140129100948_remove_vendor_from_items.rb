class RemoveVendorFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :vendor, :string
  end
end
