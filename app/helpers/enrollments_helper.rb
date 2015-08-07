module EnrollmentsHelper
  include ActivitiesHelper


  def is_waiting(enrollment)
    # If the enrollment is not committed (meaning it's low-income and the parent
    # is not willing to pay the full fee if he doesn't get the spot), the enrollment
    # is considered to be waiting.

    return true unless enrollment.committed

    annotated_enrollments = enrollments_with_rank(enrollment.activity)
    match = annotated_enrollments.select { |e| e.id == enrollment.id}

    # This enrollment is on the waiting list if its rank is > max-seats of the
    # activity.
    match.first.rank > enrollment.activity.max_seats
  end
end
