class RecruitingMailingPolicy < ApplicationPolicy
  def new?
    authorized? && user.recruiting_staff?
  end

  def create?
    authorized? && user.recruiting_staff?
  end

  def index?
    authorized? && user.recruiting_staff?
  end
end