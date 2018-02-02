class CreateReimbursements < ActiveRecord::Migration[5.1]
  def change
    create_table :reimbursements do |t|
      t.belongs_to :user, type: 'string', size: 35, index: true
      t.string :zkb_link, size: 100
      t.timestamps
    end
  end
end
