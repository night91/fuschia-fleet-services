class UserPolicy < ApplicationPolicy
  def index?
    authorized? && user.admin?
  end

  def show?
    authorized? && user.admin?
  end

  def profile?
    authorized?
  end
end