module ActivitiesHelper
  def money(data)
    # Reformat a decimal value as a dollar amount.
    "$%.2f" % data if data.present?
  end
end
