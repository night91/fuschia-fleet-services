class EveMailPolicy < ApplicationPolicy
  def show?
    authorized?
  end
end