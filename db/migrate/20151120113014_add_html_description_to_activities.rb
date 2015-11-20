class AddHtmlDescriptionToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :html_description, :text
  end
end
