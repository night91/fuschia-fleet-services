class UserPolicy < PunditPolicy
  def index?
    authorized? && user.admin?
  end

  def show?
    authorized? && user.admin?
  end

  def profile?
    authorized?
  end

  def welcome_application?
    !authorized?
  end

  def mail?
    owner? || user.recruiting_staff?
  end
end