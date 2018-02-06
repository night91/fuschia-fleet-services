class CreateApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :applications do |t|
      t.string :character_id
      t.string :status, size: 10, index: true
      t.string :token, size: 500, index: true

      t.timestamps
    end
  end
end
