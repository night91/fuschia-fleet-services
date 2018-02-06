class EveMailPolicy < PunditPolicy
  def show?
    authorized?
  end
end