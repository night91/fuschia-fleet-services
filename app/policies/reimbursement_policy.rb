class ReimbursementPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  def new?
    authorized?
  end

  def create?
    authorized?
  end

  def index?
    authorized?
  end

  def show?
    owner?
  end

  def destroy?
    owner?
  end

  def accept?
    authorized? && user.admin?
  end

  def reject?
    authorized? && user.admin?
  end
end