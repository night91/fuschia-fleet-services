class CreateAssets < ActiveRecord::Migration[5.1]
  def change
    create_table(:assets, id: false) do |t|
      t.integer :asset_id, primary_key: true
      t.string :name, size: 75
      t.timestamps
    end
  end
end
