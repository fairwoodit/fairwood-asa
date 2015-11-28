class AddVendorInfoToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :vendor_email, :string
    add_column :activities, :vendor_phone, :string
  end
end
