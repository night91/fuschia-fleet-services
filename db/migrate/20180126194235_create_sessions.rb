class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table(:sessions, id: false) do |t|
      t.string :session_id, primary_key: true, size: 25
      t.string :user_id, size: 25

      t.timestamps
    end
  end
end
