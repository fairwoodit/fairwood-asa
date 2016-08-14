class Ability
  include CanCan::Ability

  def initialize(parent)
    parent ||= Parent.new # guest user (not logged in)
    if parent.admin?
      can :manage, :all
    else
      can :manage, [Activity, Season] do
        parent.asa?
      end

      can :create, Student
      can [:read, :update, :destroy], Student, parent_id: parent.id

      can [:create, :read, :cancel, :do_cancel, :success, :low_income, :waiting_list],
          Enrollment do |e|
        e.student.blank? || (e.student.parent == parent)
      end

      can [:edit, :destroy, :update], Enrollment do
        parent.asa?
      end

      can [:index, :summary, :show, :edit, :update, :destroy], Walkathon::Pledge do
        parent.walkathon?
      end

      can :manage, Walkathon::Payment do
        parent.walkathon?
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
