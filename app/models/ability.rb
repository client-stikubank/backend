# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.superadmin?
      can :manage, :all
    else
      config_permissions(user)
    end
  end

  def config_permissions(user)
    user.roles.each do |role|
      role.permissions.each do |permission|
        can permission.action_name.to_sym, permission.object_type.constantize
      end
    end
  end
end
