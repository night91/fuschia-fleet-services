class AddFieldsToApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :applications, :corporation_id, :string, size: 50
    add_column :applications, :alliance_id, :string, size: 50
  end
end
