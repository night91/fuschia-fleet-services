class RecruitingMailingPolicy < ApplicationPolicy
  def new?
    allow_roles
  end

  def create?
    allow_roles
  end

  def index?
    allow_roles
  end

  private

  def allow_roles
    user && user.has_role?(['CEO', 'Director', 'Recruiting Manager'])
  end
end