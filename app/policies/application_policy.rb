class ApplicationPolicy < PunditPolicy
  def index?
    authorized? && user.recruiting_staff?
  end

  def show?
    authorized? && user.recruiting_staff?
  end

  def accept?
    authorized? && user.recruiting_staff?
  end

  def reject?
    authorized? && user.recruiting_staff?
  end
end