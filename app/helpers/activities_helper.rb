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

  def grade_range(activity)
    min = activity.min_grade
    min = 'K' if min.nil? || min == 0
    "#{min}-#{activity.max_grade}"
  end

  def unenrolled_student_count(activity)
    # Get the list of students belonging to the logged-in user who are eligible
    # for the activity (A).
    # Find all students already enrolled for the activity (B).
    # A-B is the set of students who haven't yet enrolled.
    eligible_students = current_parent.students.eligible(activity.min_grade,
                                                         activity.max_grade)
    eligible_students.nil? ? 0 : (eligible_students - activity.students).compact.length
  end

  def category_options(activities_by_season)
    activity_list = activities_by_season.map { |season, activities| activities}.flatten
    ['All'].concat(activity_list.map(&:category).select {|c| c.present?}.uniq.sort)
  end

  def contact_info(activity)
    vendor_email = activity.vendor_email.present? ? mail_to(activity.vendor_email, activity.vendor_email) : 'None'
    vendor_phone = activity.vendor_phone.present? ? activity.vendor_phone : 'None'
    "Email: #{CGI.escapeHTML(vendor_email)}<br>Phone: #{vendor_phone}".html_safe
  end

  def email_contact_info(activity)
    vendor_email = activity.vendor_email.present? ? mail_to(activity.vendor_email, activity.vendor_email) : 'None'
    vendor_phone = activity.vendor_phone.present? ? activity.vendor_phone : 'None'
    "Email: #{vendor_email}<br>Phone: #{vendor_phone}".html_safe
  end
end
