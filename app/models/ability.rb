class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    case user.role
      when 'admin' #ozpark admin - can associate owner
        can :manage, :all
        can :update_areas, Area
      when 'owner'
        can :manage, :all
        can :owners_payments, :owner_payments
        can :update_areas, Area
        can :get_free_spots, ParkingSearchesController
      when 'inspector'
        can :read, City
        can :read, Area
        can :read, Street
        can :read, Rate
        can :read, Payment
        can :read, User
        can :read, Car
      when 'user'
        can :manage, Payment
        can :users_payments, Payment
        can :amount, Payment
        can :manage, User
        can :manage, Car
        can :read, City
        can :read, Area
        can :read, Street
        can :read, Rate
        can :get_rates, City
        can :find_by_street, Area
        can :get_free_spots, ParkingSearchesController
      else
        # guest user
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
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
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
