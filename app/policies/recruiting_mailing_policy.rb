class RecruitingMailingPolicy < ApplicationPolicy
  def new?
    allowed_roles
  end

  def create?
    allowed_roles
  end

  def index?
    allowed_roles
  end

  private

  def allowed_roles
    user && user.has_role?(['CEO', 'Director', 'Recruiting Manager'])
  end
end