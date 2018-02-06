class ApplicationsController < ApplicationController
  def index
    authorize Application
    @applications = Application.where(status: 'pending').all
  end

  def show
    application = Application.find(params[:id])
    authorize application

    @user = application
    @user_service = UserService.new(application.token)
  end

  def accept
    application_service = ApplicationService.new(params[:application_id])
    authorize application_service.application

    application_service.accept!

    flash[:success] = 'Application accepted'
    redirect_to application_index_path
  end

  def reject
    application_service = ApplicationService.new(params[:application_id])
    authorize application_service.application

    application_service.reject!

    flash[:success] = 'Application rejected'
    redirect_to application_index_path
  end
end

