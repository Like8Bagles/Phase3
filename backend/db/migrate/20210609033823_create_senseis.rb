class CreateSenseis < ActiveRecord::Migration[5.2]
  def change
    create_table :senseis do |t|
      t.string :name
    end
  end
end
