module ReimbursementHelper
  def reimbursement_status_css_class(reimbursement)
    type = case reimbursement.status
           when 'pending'
             'info'
           when 'rejected'
             'danger'
           when 'accepted'
             'success'
           end
    "label label-md label-status label-#{type}"
  end
end
