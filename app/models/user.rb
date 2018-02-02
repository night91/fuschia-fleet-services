class User < ApplicationRecord
  include AccountSetup

  has_many :roles, dependent: :destroy
  has_many :reimbursements, dependent: :destroy

  validates :user_id, presence: true, uniqueness: true
  validates :name, presence: true
  validates :character_id, presence: true, uniqueness: true
  validates :corporation_id, presence: true
  validates :alliance_id, presence: true
  validates :token, presence: true
end
