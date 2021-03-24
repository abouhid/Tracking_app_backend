class CreateMeasures < ActiveRecord::Migration[6.1]
  def change
    create_table :measures do |t|
      t.string :type
      t.references :measurement, null: false, foreign_key: true

      t.timestamps
    end
  end
end
