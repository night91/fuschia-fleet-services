class CreateRecruitingMailings < ActiveRecord::Migration[5.1]
  def change
    create_table :recruiting_mailings do |t|
      t.string :name, null: false, unique: true, index: true
      t.timestamps
    end
  end
end
