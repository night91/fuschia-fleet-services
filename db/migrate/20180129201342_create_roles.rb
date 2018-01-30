class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.belongs_to :user, type: 'string', size: 35, index: true
      t.string :name, size: 50
      t.timestamps
    end
  end
end
