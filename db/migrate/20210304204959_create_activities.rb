class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.belongs_to :volunteer, null: false, foreign_key: true, index: true
      t.belongs_to :role, null: false, foreign_key: true, index: true
      t.date :date, null: false
      t.float :duration, null: false

      t.timestamps
    end
  end
end
