class MailPolicy < ApplicationPolicy
  def show?
    authorized? #user.recruiting_staff?
  end
end