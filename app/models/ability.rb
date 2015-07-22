class Ability
  include CanCan::Ability

  def initialize(parent)
    parent ||= Parent.new # guest user (not logged in)
    if parent.admin?
      can :manage, :all
    else
      can :read, Activity do |a|
        # This is a bit hacky. CanCanCan doesn't distinguish between index and show.
        # We want 'show' to be an admin-only view, but we want 'index' open to all.
        # For index, CanCanCan instantiates a dummy activity and passes it here. We
        # use that to decide which case we're in.

        a.name.blank?
      end

      can :create, Student
      can [:read, :update, :destroy], Student, parent_id: parent.id

      can [:create, :read, :update, :destroy], Registration do |r|
        r.student.blank? || (r.student.parent == parent)
      end
    end

    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
