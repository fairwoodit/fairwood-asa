class RemoveLakewoodEligibilityDateFromActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :lakewood_eligibility_date
  end
end
