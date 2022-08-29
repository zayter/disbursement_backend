# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, Order if user.is_shopper?
    can :complete, Order if user.is_merchant?
    can :read, Disbursement if user.is_merchant?
  end
end
