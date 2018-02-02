class Reimbursement < ApplicationRecord
  include AASM

  belongs_to :user

  default_scope { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :zkb_link, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: %w(pending accepted rejected) }

  aasm column: 'status' do
    state :pending, initial: true
    state :accepted
    state :rejected

    event :accept do
      transitions from: [:pending], to: :accepted
    end

    event :reject do
      transitions from: [:pending], to: :rejected
    end
  end
end
