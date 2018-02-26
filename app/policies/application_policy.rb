class ApplicationPolicy < PunditPolicy
  def index?
    authorized?
  end

  def show?
    authorized?
  end

  def accept?
    authorized? && user.recruiting_staff?
  end

  def reject?
    authorized? && user.recruiting_staff?
  end
end