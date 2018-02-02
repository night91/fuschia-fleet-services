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
    allowed_roles
  end

  def reject?
    allowed_roles
  end

  private

  def allowed_roles
    user && user.has_role?(['CEO', 'Director'])
  end

  def reimbursement
    record
  end
end