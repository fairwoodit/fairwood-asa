module EnrollmentsHelper
  include ActivitiesHelper


  def is_waiting(enrollment)
    annotated_enrollments = enrollments_with_rank(enrollment.activity)
    match = annotated_enrollments.select { |e| e.id == enrollment.id}

    # This enrollment is on the waiting list if its rank is > max-seats of the
    # activity.
    match.first.rank > enrollment.activity.max_seats
  end
end
