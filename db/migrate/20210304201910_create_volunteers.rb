class CreateVolunteers < ActiveRecord::Migration[6.0]
  def change
    create_table :volunteers do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :age_group
      t.string :phone
      t.string :email
      t.date :birthday
      t.string :occupation
      t.string :employer
      t.text :interests
      t.integer :background_check_status
      t.string :photo
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
