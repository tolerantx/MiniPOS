class Ability
  include CanCan::Ability

  def initialize(user)
    if user.super_admin?
      can :manage, :all
    elsif user.admin?
      can :manage, :all
      cannot :manage, Account
    end
  end
end
