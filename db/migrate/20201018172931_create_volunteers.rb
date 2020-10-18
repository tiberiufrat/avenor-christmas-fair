class CreateVolunteers < ActiveRecord::Migration[6.0]
  def change
    create_table :volunteers do |t|
      t.string :first_name
      t.string :last_name
      t.references :grade, null: false, foreign_key: {to_table: :grades}
      t.string :email
      t.string :phone
      t.timestamps
    end
  end
end
