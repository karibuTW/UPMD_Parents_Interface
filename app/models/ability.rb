# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.is_a? AdminUser
      if user.admin?
        can :manage, :all
      elsif user.viewer?
        can :read, :all
        cannot :fetch, HelloassoOrder
        cannot :read, ActiveAdmin::Comment
        can :manage, AdminUser, id: user.id
      end
    else
      can :read, :all
    end

  end
end
