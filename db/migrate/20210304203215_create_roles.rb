class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.belongs_to :user, null: false, foreign_key: true, index: true
      t.string :title, null: false, index: true
      t.text :description
      t.integer :age_requirement, default: 0
      t.integer :frequency, default: 0
      t.string :days
      t.boolean :background_check_required?, default: 0
      t.integer :status, default: 0, index: true

      t.timestamps
    end
  end
end
