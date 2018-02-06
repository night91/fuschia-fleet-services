class ReimbursementService

  attr_reader :reimbursement, :current_user

  def initialize(reimbursement_id, current_user)
    @reimbursement = Reimbursement.find(reimbursement_id)
    @current_user = current_user

    access_code = ::Auth::AuthenticationService.new.obtain_access_code(current_user[:token])
    @esi_api = ::EsiApiService.new(access_code)
  end

  def accept!
    @reimbursement.accept!
    send_mail('Accepted reimbursement')
  end

  def reject!
    @reimbursement.reject!
    send_mail('Rejected reimbursement')
  end

  private

  def send_mail(subject)
    @esi_api.send_simple_mail(
      @current_user[:character_id],
      @reimbursement.user[:character_id],
      subject,
      @reimbursement[:zkb_link]
    )
  end
end