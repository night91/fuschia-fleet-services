class Application < ApplicationRecord
  include AASM

  default_scope { order(created_at: :desc) }

  validates :character_id, presence: true
  validates :token, presence: true
  validates :name, presence: true
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
