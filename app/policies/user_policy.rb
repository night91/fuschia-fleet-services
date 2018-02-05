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

  def mail?
    owner? || user.recruiting_staff?
  end
end