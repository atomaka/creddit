# policies/post_policy.rb
class PostPolicy < ApplicationPolicy
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
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
