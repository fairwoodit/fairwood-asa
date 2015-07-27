module EnrollmentsHelper
  include ActivitiesHelper

  def unassigned_students(enrollment)
    # Get the list of students belonging to the logged-in user (A)
    # Find all students already enrolled for the activity (B).
    # A-B is the set of students who haven't yet enrolled. However, if we're
    # editing an enrollment, we want to include the current registrant in our list,
    # so add that back in.
    (current_parent.students - enrollment.activity.students + [enrollment.student]).
      compact.sort.uniq
  end

  def is_waiting(enrollment)
    annotated_enrollments = enrollments_with_rank(enrollment.activity)
    match = annotated_enrollments.select { |e| e.id == enrollment.id}

    # This enrollment is on the waiting list if its rank is > max-seats of the
    # activity.
    match.first.rank > enrollment.activity.max_seats
  end
end
