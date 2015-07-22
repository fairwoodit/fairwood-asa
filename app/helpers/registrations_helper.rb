module RegistrationsHelper
  def unassigned_students(registration)
    # Get the list of students belonging to the logged-in user (A)
    # Find all students already registered for the activity (B).
    # A-B is the set of students who haven't yet registered. However, if we're
    # editing a registration, we want to include the current registrant in our list,
    # so add that back in.
    (current_parent.students - registration.activity.students + [registration.student]).
      compact.sort.uniq
  end
end
