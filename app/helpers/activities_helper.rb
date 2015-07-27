module ActivitiesHelper
  def money(data)
    # Reformat a decimal value as a dollar amount.
    "$%.2f" % data if data.present?
  end

  def friendly_date(date)
    date.strftime("%m/%d/%Y")
  end

  def enrollments_with_rank(activity)
    enrollment_list = Enrollment.where(activity: activity, committed: true).order(:id)
    current_rank = 1
    enrollment_list.each do |enrollment|
      enrollment.rank = current_rank
      current_rank += 1
    end
  end
end
