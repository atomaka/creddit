# policies/subcreddit_policy.rb
class SubcredditPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.registered?
  end

  def update?
    record.owner == user
  end
end
