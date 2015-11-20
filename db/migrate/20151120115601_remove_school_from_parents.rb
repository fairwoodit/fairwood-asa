class RemoveSchoolFromParents < ActiveRecord::Migration
  def change
    remove_column :parents, :school
  end
end
