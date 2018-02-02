class Reimbursement < ApplicationRecord
  belongs_to :user

  default_scope { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :zkb_link, presence: true, uniqueness: true
end
