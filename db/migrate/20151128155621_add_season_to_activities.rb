class AddSeasonToActivities < ActiveRecord::Migration
  def change
    add_reference :activities, :season, index: true, foreign_key: true
  end
end
