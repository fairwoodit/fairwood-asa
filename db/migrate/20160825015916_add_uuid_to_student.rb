class AddUuidToStudent < ActiveRecord::Migration
  def change
    add_column :students, :uuid, :string
    add_index :students, :uuid, unique: true
  end
end
