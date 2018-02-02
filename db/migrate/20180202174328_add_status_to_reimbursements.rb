class AddStatusToReimbursements < ActiveRecord::Migration[5.1]
  def change
    add_column :reimbursements, :status, :string, size: 10, default: 'pending', null: false
    add_index :reimbursements, :status
  end
end
