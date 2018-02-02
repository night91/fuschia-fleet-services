class ReimbursementsController < ApplicationController
  def index
    authorize Reimbursement
    @reimbursements = policy_scope(Reimbursement)
  end

  def new
    authorize Reimbursement
    @reimbursement = Reimbursement.new(user: current_user)
  end

  def create
    authorize Reimbursement

    reimbursement = Reimbursement.new(reimbursement_params)
    reimbursement.user = current_user

    if reimbursement.save
      flash[:success] = 'Reimbursement requested'
      redirect_to reimbursements_path
    else
      flash[:error] = 'Error creating reimbursement'
      redirect_to new_reimbursement_path
    end
  end

  def show
    @reimbursement = Reimbursement.find(params[:id])
    authorize @reimbursement
  end

  def destroy
    reimbursement = Reimbursement.find(params[:id])
    authorize reimbursement

    delete_reimbursement(reimbursement, 'Reimbursement deleted')
  end

  def accept
    reimbursement = Reimbursement.find(params[:reimbursement_id])
    authorize reimbursement

    ReimbursementService.new(reimbursement, current_user).accept

    delete_reimbursement(reimbursement, 'Reimbursement accepted')
  end

  def reject
    reimbursement = Reimbursement.find(params[:reimbursement_id])
    authorize reimbursement

    ReimbursementService.new(reimbursement, current_user).reject

    delete_reimbursement(reimbursement, 'Reimbursement rejected')
  end

  private

  def reimbursement_params
    params.require(:reimbursement).permit(:zkb_link)
  end

  def delete_reimbursement(reimbursement, message)
    reimbursement.delete
    flash[:success] = message
    redirect_to reimbursements_path
  end
end
