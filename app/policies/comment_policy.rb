# policies/comment_policy.rb
class CommentPolicy < ApplicationPolicy
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
