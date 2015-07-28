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
    (eligible_students - activity.students).compact.length
  end

  def category_options(activity_list)
    ['All'].concat(activity_list.map(&:category).select {|c| c.present?}.uniq.sort)
  end
end
