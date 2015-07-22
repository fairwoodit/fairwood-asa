class ConvertActivityDescriptionToText < ActiveRecord::Migration
  def change
    remove_column :activities, :description
    add_column :activities, :description, :text
  end
end
