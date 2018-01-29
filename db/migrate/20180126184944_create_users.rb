class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table(:users, id: false) do |t|
      t.string :user_id, size: 25, primary_key: true

      t.string :name, size: 50
      t.string :character_id, index: true
      t.string :corporation_id
      t.string :alliance_id
      t.string :token, size: 500

      t.timestamps
    end
  end
end
