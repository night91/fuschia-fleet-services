class ApplicationService
  attr_reader :application

  def initialize(application_id)
    @application = Application.find(application_id)
  end

  def accept!
    @application.accept!
  end

  def reject!
    @application.reject!
  end
end